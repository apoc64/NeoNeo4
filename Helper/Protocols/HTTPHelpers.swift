//
//  HTTPHelpers.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

struct HTTPRequest {
    let service: ServiceProviding
    let path: String
    let queryItems: [URLQueryItem]?
    // let method: HTTPMethod
    // auth, headers...?
    
    var url: URL? {
        return components.url
    }
    
    private var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = service.baseURLString
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
}
