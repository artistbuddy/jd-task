//
//  StationsViewController.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-07.
//  Copyright © 2018 Karol. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController {
    private var viewModel: StationsViewModelProtocol
    private let collectionView: UICollectionView
    
    private lazy var activityView: UIActivityIndicatorView = {
       let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.hidesWhenStopped = true
        view.startAnimating()
        
        return view
    }()
    
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
        
        self.collectionView.isHidden = true
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        collectionViewConstraints()
        activityViewConstraints()
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor.white
        
        setupCollectionView()
        setupActivityView()
        
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
    
    private func setupActivityView() {
        self.activityView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.activityView)
        
        self.viewModel.shouldActivityIndicator = { [weak self] (show) in
            if show {
                self?.activityView.startAnimating()
                self?.collectionView.isHidden = true
            } else {
                self?.activityView.stopAnimating()
                self?.collectionView.isHidden = false
            }           
        }
    }
    
    private func activityViewConstraints() {
        NSLayoutConstraint.activate([
            self.activityView.widthAnchor.constraint(equalToConstant: 40),
            self.activityView.heightAnchor.constraint(equalToConstant: 40),
            self.activityView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
    }
    
}
