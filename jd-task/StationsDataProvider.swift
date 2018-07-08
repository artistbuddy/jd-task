//
//  StationsDataProvider.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-07.
//  Copyright © 2018 Karol. All rights reserved.
//

import Foundation
import MapKit

class StationInfo: NSObject {
    let id: String
    let name: String
    let lat: Double
    let long: Double
    let bikes: String
    let freeRacks: String
    let racks: String
    let updated: String
    var distance: String?
    var address: String?
    
    init(id: String, name: String, lat: Double, long: Double, bikes: String, freeRacks: String, racks: String, updated: String) {
        self.id = id
        self.name = name
        self.lat = lat
        self.long = long
        self.bikes = bikes
        self.freeRacks = freeRacks
        self.racks = racks
        self.updated = updated
    }
}

extension StationInfo: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
    }
}

protocol StationsDataSource {
    var numberOfStations: Int { get }
    
    func getAllStations() -> [StationInfo]
    func getStation(atIndex index: Int) -> StationInfo
}

class StationsDataProvider {
    private var data: StationsData?
    private var stations: [StationInfo] {
        guard let stations = self.data?.stations else {
            return []
        }
        
        return stations
    }
    
    private let api: APIController
    private let location: LocationManager
    
    init(apiControler: APIController, locationManager: LocationManager) {
        self.api = apiControler
        self.location = locationManager
    }
    
    func download(success: (() -> Void)?, failure: APIFailureCallback) {
        let query = StationsQuery()
        
        api.execute(query, success: { (data) in
            self.data = data
            
            if let position = self.location.lastLocation {
                let formatter = MKDistanceFormatter()
                
                for station in data.stations {
                    let distance = position.distance(from: CLLocation(latitude: station.coordinate.latitude, longitude: station.coordinate.longitude))
                    station.distance = formatter.string(fromDistance: distance)
                }
            }
            
            success?()
        }, failure: failure)
    }
}

extension StationsDataProvider: StationsDataSource {
    var numberOfStations: Int {
        return stations.count
    }
    
    func getAllStations() -> [StationInfo] {
        return stations
    }
    
    func getStation(atIndex index: Int) -> StationInfo {
        return stations[index]
    }
    
}
