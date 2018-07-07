//
//  StationsDataProvider.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-07.
//  Copyright © 2018 Karol. All rights reserved.
//

import Foundation

struct StationInfo {
    let id: String
    let name: String
    let lat: Double
    let long: Double
    let bikes: String
    let freeRacks: String
    let racks: String
    let updated: String
}

protocol StationsDataSource {
    var numberOfStations: Int { get }
    
    func getAllStations() -> [StationInfo]
    func getStation(atIndex index: Int) -> StationInfo
}

class StationsDataProvider {
    private var data: StationsData?
    private let api: APIController
    
    init(apiControler: APIController) {
        self.api = apiControler
    }
    
    func download(success: (() -> Void)?, failure: APIFailureCallback) {
        let query = StationsQuery()
        
        api.execute(query, success: { (data) in
            self.data = data
            success?()
        }, failure: failure)
    }
}

extension StationsDataProvider: StationsDataSource {
    var numberOfStations: Int {
        return self.data?.stations.count ?? 0
    }
    
    func getAllStations() -> [StationInfo] {
        return self.data?.stations ?? []
    }
    
    func getStation(atIndex index: Int) -> StationInfo {
        guard let station = self.data?.stations[index] else {
            fatalError("Stations not found index")
        }
        
        return station
    }
    
}
