//
//  StationsViewModel.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-07.
//  Copyright © 2018 Karol. All rights reserved.
//

import UIKit

protocol StationsViewModelProtocol {
    var collectionView: UICollectionView { get }
}

protocol StationsViewModelDelegate: StationsCollectionDelegate {
    
}

class StationsViewModel: StationsViewModelProtocol {
    weak var delegate: StationsViewModelDelegate?
    
    private lazy var controller: StationsCollectionController = {
       let controller = StationsCollectionController(dataSource: self.provider)
        controller.delegate = self.delegate
        
        return controller
    }()
    private var provider: StationsDataProvider
    
    init(dataProvider: StationsDataProvider) {
        self.provider = dataProvider
        
        refreshData()
    }
    
    private func refreshData() {
        provider.download(success: { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }}, failure: nil)
    }
    
    //MARK:- StationsViewModelProtocol
    var collectionView: UICollectionView {
        return self.controller.collectionView
    }
}


