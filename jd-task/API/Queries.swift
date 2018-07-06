//
//  Queries.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-06.
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

struct StationsData: Decodable {
    let stations: [StationInfo]
    
    enum CodingKeys: String, CodingKey {
        case features
    }
    
    enum FeaturesKeys: String, CodingKey {
        case geometry
        case id
        case properties
    }
    
    enum GeometryKeys: String, CodingKey {
        case coordinates
    }
    
    enum PropertiesKeys: String, CodingKey {
        case freeRacks = "free_racks"
        case bikes
        case name = "label"
        case racks = "bike_racks"
        case updated
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        var featuresContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
        
        var stations = [StationInfo]()
        if let count = featuresContainer.count {
            stations.reserveCapacity(count)
        }
        
        while !featuresContainer.isAtEnd {
            let feature = try featuresContainer.nestedContainer(keyedBy: FeaturesKeys.self)
            
            let id = try feature.decode(String.self, forKey: .id)
            
            let propertiesContainer = try feature.nestedContainer(keyedBy: PropertiesKeys.self, forKey: .properties)
            let freeRacks = try propertiesContainer.decode(String.self, forKey: .freeRacks)
            let racks = try propertiesContainer.decode(String.self, forKey: .racks)
            let bikes = try propertiesContainer.decode(String.self, forKey: .bikes)
            let name = try propertiesContainer.decode(String.self, forKey: .name)
            let updated = try propertiesContainer.decode(String.self, forKey: .updated)
            
            let geometryContainer = try feature.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
            let coords = try geometryContainer.decode([Double].self, forKey: .coordinates)
            let long = coords[0]
            let lat = coords[1]
            
            let station = StationInfo(id: id,
                                      name: name,
                                      lat: lat,
                                      long: long,
                                      bikes: bikes,
                                      freeRacks: freeRacks,
                                      racks: racks,
                                      updated: updated)
            stations.append(station)
        }
        
        self.stations = stations
    }
}

struct StationsQuery: APIQuery {
    typealias Result = StationsData
    
    var parameters: [String : String]? {
        return ["mtype" : "pub_transport",
                "co" : "stacje_rowerowe"]
    }
    
    var path: String {
        return "mim/plan/map_service.html"
    }
}
