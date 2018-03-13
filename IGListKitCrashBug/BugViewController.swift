//
//  BugViewController.swift
//  IGListKitCrashBug
//
//  Created by Marcus Wu on 2018/3/13.
//  Copyright © 2018年 MarcusWu. All rights reserved.
//

import UIKit
import IGListKit

class BugViewController: UIViewController {

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
        
        adapter.dataSource = self
        adapter.collectionView = self.collectionView
        
        return adapter
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: true,
                                                                                                           topContentInset: 0,
                                                                                                           stretchToEdge: true))
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        
        return collectionView
    }()
    
    lazy var provider: ViewModelProvider = {
        let provider = ViewModelProvider()
        
        provider.delegate = self
        
        return provider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.collectionView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = self.view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
}

extension BugViewController: ViewModelProviderDelegate {
    func viewMdoelsDidUpdate() {
        self.adapter.reloadData(completion: nil)
    }
}

extension BugViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.provider.viewModels!
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return FormTextViewSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
