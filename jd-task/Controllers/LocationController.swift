//
//  LocationController.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-08.
//  Copyright © 2018 Karol. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManager {
    var lastLocation: CLLocation? { get }
    
    func requestAuthorization()
    func shouldRequestAuthorization() -> Bool
    func getCurrentLocation(_ location: @escaping (_ :  [CLLocation]) -> Void)
    
    /*
     func start()
     func stop()
     */
}

class LocationController: NSObject {    
    private var last: CLLocation?
    private var current: (([CLLocation]) -> Void)?
    
    private lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        return manager
    }()
    
    override init() {
        super.init()
        
        self.manager.startUpdatingLocation()
    }
}

extension LocationController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.manager.startUpdatingLocation()
        default:
            self.manager.stopUpdatingHeading()
            self.last = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.last = locations.first
        self.current?(locations)
    }
}

extension LocationController: LocationManager {
    var lastLocation: CLLocation? {
        return self.last
    }
    
    func requestAuthorization() {
        self.manager.requestWhenInUseAuthorization()
    }
    
    func shouldRequestAuthorization() -> Bool {
        switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                return true
            case .denied, .restricted:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return false
        }
    }
    
    func getCurrentLocation(_ location: @escaping ([CLLocation]) -> Void) {
        self.current = location
    }
    
}
