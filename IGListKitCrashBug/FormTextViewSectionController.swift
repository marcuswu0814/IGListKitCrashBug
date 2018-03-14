//
//  FormTextViewSectionController.swift
//  IGListKitCrashBug
//
//  Created by Marcus Wu on 2018/3/13.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit
import IGListKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

class FormTextViewSectionController: ListSectionController {
    
    lazy var cell: FormTextViewCell = UIView.fromNib()
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
        self.cell.config(with: self.viewModel!)

        let height = self.heightFor(self.cell)
        
        return CGSize(width: (self.collectionContext?.containerSize.width)!, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = self.collectionContext?.dequeueReusableCell(withNibName: "FormTextViewCell",
                                                                     bundle: nil,
                                                                     for: self,
                                                                     at: 0)
            else {
            fatalError()
        }
        
        if let cell = cell as? FormTextViewCell {
            cell.delegate = self
            cell.config(with: self.viewModel!)
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
        
        self.viewModel?.inputText = string
        
        if let cell = cell as? FormTextViewCell {
            cell.config(with: self.viewModel!)
        }
        
        self.height = self.heightFor(cell!)
    }
    
    fileprivate func heightFor(_ cell: UICollectionViewCell) -> CGFloat {
        cell.layoutIfNeeded()
        
        let size = cell.contentView.systemLayoutSizeFitting((self.collectionContext?.containerSize)!,
                                                            withHorizontalFittingPriority: UILayoutPriority(rawValue: 1000),
                                                            verticalFittingPriority: UILayoutPriority(rawValue: 250))
        
        return size.height
    }
}
