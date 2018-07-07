//
//  StationsViewController.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-07.
//  Copyright © 2018 Karol. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController {
    private let viewModel: StationsViewModelProtocol
    private let collectionView: UICollectionView
    
    init(viewModel: StationsViewModelProtocol) {
        self.viewModel = viewModel
        self.collectionView = viewModel.collectionView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        collectionViewConstraints()
    }
    
    private func setupViews() {
        setupCollectionView()
        
        updateViewConstraints()
    }
    
    private func setupCollectionView() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.frame = self.view.bounds
        
        self.collectionView.alwaysBounceVertical = true
        
        self.view.addSubview(self.collectionView)
    }
    
    private func collectionViewConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
}
