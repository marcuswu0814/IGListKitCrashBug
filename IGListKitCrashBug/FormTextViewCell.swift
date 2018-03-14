//
//  FormTextViewCellCollectionViewCell.swift
//  IGListKitCrashBug
//
//  Created by Marcus Wu on 2018/3/13.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit

protocol FormTextViewCellCollectionViewCellDelegate: class {
    func textViewDidChange(_ string: String?)
}

class FormTextViewCell: UICollectionViewCell {

    weak var delegate: FormTextViewCellCollectionViewCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .red
        self.textView.delegate = self
    }

    func config(with viewModel: FormTextViewViewModel) {
        self.label.text = viewModel.title
        self.textView.text = viewModel.inputText
        self.textView.textContainer.lineFragmentPadding = 0;
        self.textView.isScrollEnabled = false
    }
    
}

extension FormTextViewCell : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.textViewDidChange(textView.text)
    }
}
