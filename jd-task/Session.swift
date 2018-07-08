//
//  Session.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-07.
//  Copyright © 2018 Karol. All rights reserved.
//

import Foundation

struct Session {
    static let api = APIController(baseURL: URL(string: "http://www.poznan.pl")!)
    static let location: LocationManager = LocationController()
    
}
