//
//  StationsCollectionController.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-07.
//  Copyright © 2018 Karol. All rights reserved.
//

import UIKit

protocol StationsCollectionDelegate: class {
    func didSelectStation(_ station: StationInfo)
}

class StationsCollectionController: NSObject {
    weak var delegate: StationsCollectionDelegate?
    private let dataSource: StationsDataSource
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        return layout
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        
        collection.backgroundColor = UIColor.yellow

        collection.register(UINib(nibName: String(describing: StationCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: StationCollectionViewCell.cellReusableID)
        
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    init(dataSource: StationsDataSource) {
        self.dataSource = dataSource
    }
}

extension StationsCollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.numberOfStations
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //TODO: Implement Stations cell
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StationCollectionViewCell.cellReusableID, for: indexPath) as? StationCollectionViewCell else {
            fatalError("Could't deque cell: \(StationCollectionViewCell.cellReusableID)")
        }
        
        print(self.dataSource.getStation(atIndex: indexPath.row).name)
        
        return cell
    }
        
}

extension StationsCollectionController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectStation(self.dataSource.getStation(atIndex: indexPath.row))
    }
}


