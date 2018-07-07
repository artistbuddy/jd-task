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

class StationsViewModel: StationsViewModelProtocol {
    private let controller: StationsCollectionController
    private(set) var provider: StationsDataProvider
    
    init(controller: StationsCollectionController, dataProvider: StationsDataProvider) {
        self.controller = controller
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


