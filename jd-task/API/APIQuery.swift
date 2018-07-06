//
//  APIQuery.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-06.
//  Copyright © 2018 Karol. All rights reserved.
//

import Foundation

protocol APIQuery {
    associatedtype Result: Decodable
    
    var path: String { get }
    var parameters: [String: String]? { get }
}

extension APIQuery {
    private var url: URL {
        var components = URLComponents()
        
        components.path = self.path
        
        if let parameters = self.parameters {
            components.queryItems = []
            
            for (name, value) in parameters {
                let item = URLQueryItem(name: name, value: value)
                components.queryItems!.append(item)
            }
        }
        
        guard let url = components.url else {
            fatalError("APIQuery invalid URL")
        }
        
        return url
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = "GET"
        
        return request
    }
}
