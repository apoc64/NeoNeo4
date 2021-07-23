//
//  CryptoService.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 1/31/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
import Combine

struct CryptoResponse {
    let status: String
    let data: CryptoData
}

struct CryptoData: Decodable {
    let coins: [Coin]
}

struct Coin: Decodable, Hashable {
    let name: String
    let price: String
}

extension CryptoResponse: ServiceResponseModel {
    static var defaultRequest: HTTPRequest? {
        HTTPRequest(
            service: Service.coin,
            path: "/v1/public/coins",
            additionalQueryItems: [
                URLQueryItem(name: "base", value: "USD"),
                URLQueryItem(name: "timePeriod", value: "24h")
        ])
    }
}

