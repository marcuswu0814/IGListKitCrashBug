//
//  ViewController.swift
//  IGListKitCrashBug
//
//  Created by Marcus Wu on 2018/3/13.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pushToCollectionView(_ sender: Any) {
        let viewController = BugViewController()
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

