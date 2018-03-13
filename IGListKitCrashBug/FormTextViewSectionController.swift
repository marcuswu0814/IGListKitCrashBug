//
//  FormTextViewSectionController.swift
//  IGListKitCrashBug
//
//  Created by Marcus Wu on 2018/3/13.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit
import IGListKit

class FormTextViewSectionController: ListSectionController {
    
    var viewModel: FormTextViewViewModel?
    var cacheHeight: CGFloat?
    var height: CGFloat = 0 {
        didSet {
            if cacheHeight != height {
                self.cacheHeight = height
                self.collectionContext?.invalidateLayout(for: self, completion: nil)
            }
        }
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let height = self.height == 0 ? 75.0 : self.height
        
        return CGSize(width: (self.collectionContext?.containerSize.width)!, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = self.collectionContext?.dequeueReusableCell(withNibName: "FormTextViewCellCollectionViewCell",
                                                                     bundle: nil,
                                                                     for: self,
                                                                     at: 0)
            else {
            fatalError()
        }
        
        if let cell = cell as? FormTextViewCellCollectionViewCell {
            cell.delegate = self
            cell.config(with: self.viewModel!)
            self.height = self.heightFor(cell)
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        if let object = object as? FormTextViewViewModel {
            self.viewModel = object
        }
    }
}

extension FormTextViewSectionController: FormTextViewCellCollectionViewCellDelegate {
    
    func textViewDidChange(_ string: String?) {
        let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self)
        
        self.height = self.heightFor(cell!)
    }
    
    fileprivate func heightFor(_ cell: UICollectionViewCell) -> CGFloat {
        cell.layoutIfNeeded()
        
        let size = cell.contentView.systemLayoutSizeFitting((self.collectionContext?.containerSize)!)
        
        return size.height
    }
}
