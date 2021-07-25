//
//  TestHelper.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
@testable import NeoNeo4

class TestHelper: NSObject {
    
    override init() {
        super.init()
        
        log("TestHelper Running")
        setup()
    }
    
    func setup(config: HelperConfig = defaultConfig) {
        Helper.configure(config)
    }
    
    private static let defaultConfig = HelperConfig(
        loggingPriority: .required,
        dataTaskPublisher: MockURLSession(),
        userDefaultable: MockUserDefaults(),
        analyticsProviding: NoAnalytics()
    )
}
