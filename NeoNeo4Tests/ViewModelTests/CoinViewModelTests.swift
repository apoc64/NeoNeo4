//
//  NeoNeo4Tests.swift
//  NeoNeo4Tests
//
//  Created by Steve Schwedt on 1/31/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import XCTest
@testable import NeoNeo4

class CoinViewModelTests: XCTestCase {

    override class func setUp() {
        MockURLSession.mock(request: CryptoResponse.defaultRequest, jsonFileName: "coinResponse")
    }

    func testSuccessfulResponse() {
        let exp = expectation(description: "wait")
        
        let coinListVM = CoinListViewModel()
        coinListVM.fetchCoins()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            let coins = coinListVM.coins
            XCTAssertEqual(coins.count, 2)
            XCTAssertEqual(coins.first?.displayString, "Bitcoin - 33056.37")
            XCTAssertEqual(coins.last?.displayString, "Ethereum - 1315.04")
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 0.2)
    }
}
