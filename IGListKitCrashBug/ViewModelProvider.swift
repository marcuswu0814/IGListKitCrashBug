//
//  ViewModelProvider.swift
//  IGListKitCrashBug
//
//  Created by Marcus Wu on 2018/3/13.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit
import IGListKit

protocol ViewModelProviderDelegate: class {
    func viewMdoelsDidUpdate()
}

let lorem = """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
"""

class ViewModelProvider: NSObject {

    weak var delegate: ViewModelProviderDelegate?
    
    var viewModels: [ListDiffable]?
    
    
    override init() {
        super.init()
        
        self.viewModels = [FormTextViewViewModel("1", inputText: "1-1"),
                           FormTextViewViewModel("2", inputText: "2-1"),
                           FormTextViewViewModel("3", inputText: "3-1"),
                           FormTextViewViewModel("4", inputText: "4-1"),
                           FormTextViewViewModel("5", inputText: "5-1"),
                           FormTextViewViewModel("6", inputText: "6-1"),
                           FormTextViewViewModel("7", inputText: "7-1"),
                           FormTextViewViewModel("8", inputText: "8-1"),
                           FormTextViewViewModel("9", inputText: "9-1"),
                           FormTextViewViewModel("10", inputText: "10-1"),
                           FormTextViewViewModel("11", inputText: "11-1"),
                           FormTextViewViewModel("12", inputText: "12-1"),
                           FormTextViewViewModel("13", inputText: "13-1"),
                           FormTextViewViewModel("14", inputText: "14-1")]
        
        let semaphore = DispatchSemaphore(value: 0)

        DispatchQueue.global().async {
            sleep(1)
            semaphore.signal()
            
            DispatchQueue.main.async {
                self.viewModels = [FormTextViewViewModel("1", inputText: lorem),
                                   FormTextViewViewModel("2", inputText: lorem),
                                   FormTextViewViewModel("3", inputText: lorem),
                                   FormTextViewViewModel("4", inputText: lorem),
                                   FormTextViewViewModel("5", inputText: lorem),
                                   FormTextViewViewModel("6", inputText: lorem),
                                   FormTextViewViewModel("7", inputText: lorem),
                                   FormTextViewViewModel("8", inputText: lorem),
                                   FormTextViewViewModel("9", inputText: lorem),
                                   FormTextViewViewModel("10", inputText: lorem),
                                   FormTextViewViewModel("11", inputText: lorem),
                                   FormTextViewViewModel("12", inputText: lorem),
                                   FormTextViewViewModel("13", inputText: lorem),
                                   FormTextViewViewModel("14", inputText: lorem)]
                
                self.delegate?.viewMdoelsDidUpdate()
            }
        }
    }
}
