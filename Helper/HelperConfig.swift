//
//  HelperConfig.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

/*
 Helper is intended to aid in the building of modern apps
 using SwiftUI and Combine
 */

import Foundation

struct HelperConfig {
    let loggingPriority: LoggingPriority
    let dataTaskPublisher: DataTaskPublishing
    let userDefaultable: UserDefaultable
    let analyticsProviding: AnalyticsProviding
}

/**
 Sets up a group of helpers for apps using Combine
 */
class Helper {
    
    /**
     Configure Helper
     - parameter config: A HelperConfig struct with necessary info
     */
    static func configure(_ config: HelperConfig) {
        log("Helper is helping")
        
        LoggingConfig.setPriority(config.loggingPriority)
        Container.register(DataTaskPublishing.self) { _ in config.dataTaskPublisher }
        Container.register(UserDefaultable.self) { _ in config.userDefaultable }
        Container.register(AnalyticsProviding.self) { _ in config.analyticsProviding }
        
        log("*** beep beep boob beep beep ***")
    }
}
