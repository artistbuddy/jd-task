//
//  StationDetailsViewController.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-08.
//  Copyright © 2018 Karol. All rights reserved.
//

import UIKit
import MapKit

class StationDetailsViewController: UIViewController {
    private let station: StationInfo
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        
        map.delegate = self
        map.register(BicycleAnnotationView.self, forAnnotationViewWithReuseIdentifier: BicycleAnnotationView.reusableID)
        
        map.showsUserLocation = true
        map.mapType = .mutedStandard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.0075, longitudeDelta: 0.0075)
        let region = MKCoordinateRegion(center: self.station.coordinate, span: span)
        
        map.setRegion(region, animated: true)
        map.addAnnotation(self.station)
        
        return map
    }()
    
    private lazy var detailsView: UIView = {
        guard let view = Bundle.main.loadNibNamed(String(describing: StationCollectionViewCell.self), owner: self, options: nil)?.first as? StationCollectionViewCell else {
            fatalError("Could't load nib: \(StationCollectionViewCell.self)")
        }
        
        view.id = self.station.id
        view.name = self.station.name
        view.distance = self.station.distance ?? "?"
        view.address = self.station.address ?? "?"
        view.bikes = self.station.bikes
        view.freeRacks = self.station.freeRacks
        
        view.layer.cornerRadius = 0
        
        return view
    }()
    
    init(station: StationInfo) {
        self.station = station
        
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
        
        detailsViewConstraints()
        mapViewConstraints()
    }
    private func setupViews() {
        setupDetailsView()
        setupMapView()
        
        updateViewConstraints()
    }
    
    private func setupMapView() {
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.mapView)
    }
    
    private func mapViewConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.detailsView.topAnchor)
            ])
        
    }
    
    private func setupDetailsView() {
        self.detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.detailsView)
    }
    
    private func detailsViewConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.detailsView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.detailsView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.detailsView.heightAnchor.constraint(equalToConstant: 220),
            self.detailsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])

    }
}

extension StationDetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        guard let view = mapView.dequeueReusableAnnotationView(withIdentifier: BicycleAnnotationView.reusableID, for: annotation) as? BicycleAnnotationView else {
            return nil
        }
        
        view.bikes = self.station.bikes
        
        return view
    }
}
