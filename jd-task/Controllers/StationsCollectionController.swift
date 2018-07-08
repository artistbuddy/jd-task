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
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        
        return layout
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        
        collection.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        collection.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StationCollectionViewCell.cellReusableID, for: indexPath) as? StationCollectionViewCell else {
            fatalError("Could't deque cell: \(StationCollectionViewCell.cellReusableID)")
        }
        
        let station = self.dataSource.getStation(atIndex: indexPath.row)
        
        cell.id = station.id
        cell.name = station.name
        cell.distance = station.distance ?? "?"
        cell.address = station.address ?? "?"
        cell.bikes = station.bikes
        cell.freeRacks = station.freeRacks
        
        return cell
    }
        
}

extension StationsCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectStation(self.dataSource.getStation(atIndex: indexPath.row))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 40, height: CGFloat(225))
    }
}


