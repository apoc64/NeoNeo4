//
//  Logger.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

func log(_ string: String, priority: LoggingPriority = .required, analytics: Bool = false, options: [String: Any]? = nil) {

    #if !RELEASE
    if priority.rawValue >= LoggingConfig.minimumPriority.rawValue {
        print(Date.timestamp + ": " + string)
    }
    #endif
    
    if analytics {
        let provider = Container.resolve(AnalyticsProviding.self)
        provider?.logAnalytics(string: string, options: options)
    }
}

class LoggingConfig {
    private(set) static var minimumPriority: LoggingPriority = .required
    
    static func setPriority(_ priority: LoggingPriority) {
        minimumPriority = priority
        #if !RELEASE
        print("Minimum logging priority for console set to \(priority)")
        #endif
    }
}

enum LoggingPriority: Int {
    case low
    case medium
    case high
    case required
}

protocol AnalyticsProviding {
    func logAnalytics(string: String, options: [String: Any]?)
}

struct NoAnalytics: AnalyticsProviding {
    func logAnalytics(string: String, options: [String : Any]?) { }
}
