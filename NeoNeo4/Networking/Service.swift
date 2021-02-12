//
//  Service.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/3/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

enum Service: String, ServiceProviding {
    case coin
    case nasa
    
    var baseURLString: String {
        switch self {
        case .coin:
            switch Environment.current {
            case .development:
                return "api.coinranking.com"
            case .staging:
                return "api.coinranking.com"
            case .production:
                return "api.coinranking.com"
            }
        case .nasa:
            switch Environment.current {
            default:
                return "api.nasa.gov"
            }
        }
    }
}
