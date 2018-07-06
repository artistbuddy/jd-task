//
//  APIController.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-06.
//  Copyright © 2018 Karol. All rights reserved.
//

import Foundation

class APIController {
    private let session: URLSession
    private let jsonDecoder = JSONDecoder()
    private let baseURL: URL
    
    init(urlSession: URLSession, baseURL: URL) {
        self.session = urlSession
        self.baseURL = baseURL
    }
    
    convenience init(baseURL: URL) {
        self.init(urlSession: URLSession.shared, baseURL: baseURL)
    }
    
    func execute<Query: APIQuery, Result>(_ query: Query, success: APIQueryCallback<Result>?, failure: APIFailureCallback) where Result == Query.Result {
        
        var urlRequest = query.urlRequest
        urlRequest.url = URL(string: urlRequest.url!.absoluteString, relativeTo: self.baseURL)
        
        let task = self.session.dataTask(with: urlRequest) { [jsonDecoder] (data, response, error) in
            
            if let error = error {
                failure?(error.localizedDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                failure?(String(response.statusCode))
            } else {
                print("\(query.path): response is nil")
            }
            
            if let data = data {
                do {
                    let result = try jsonDecoder.decode(Result.self, from: data)
                    success?(result)
                } catch let error {
                    failure?(String(describing: error))
                }
            }  else {
                print("\(query.path): data is nil")
            }
        }
        
        task.resume()
    }}
