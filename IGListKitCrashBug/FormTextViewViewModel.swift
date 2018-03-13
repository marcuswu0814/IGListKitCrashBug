//
//  FormTextViewViewModel.swift
//  IGListKitCrashBug
//
//  Created by Marcus Wu on 2018/3/13.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit
import IGListKit

class FormTextViewViewModel: NSObject {
    
    fileprivate(set) var title: String?
    var inputText: String?
    
    init(_ title: String?, inputText: String?) {
        self.title = title
        self.inputText = inputText
    }
    
}

extension FormTextViewViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? FormTextViewViewModel else { return false }
        
        return self == object
    }
}
