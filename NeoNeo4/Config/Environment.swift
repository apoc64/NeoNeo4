//
//  Environments.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

enum Environment: String {
    case development
    case staging
    case production
    
    static let environmentsUserDefaultKey = "environmentsUserDefaultKey"
    private static var currentEnvironment: Environment?
}

extension Environment {
    
    static var current: Environment {
        #if RELEASE
        return Environment.production
        #else
        return Environment.currentEnvironment ?? environmentFromUserDefaults()
        #endif
    }
    
    private static func environmentFromUserDefaults() -> Environment {
        if let environmentName = UserDefaults.fromContainer.string(forKey: Environment.environmentsUserDefaultKey) {
            currentEnvironment = Environment(rawValue: environmentName)
        } else {
            #if DEBUG
            UserDefaults.fromContainer.set(Environment.development.rawValue, forKey: environmentsUserDefaultKey)
            currentEnvironment = .development
            #else
            UserDefaults.fromContainer.set(Environment.production.rawValue, forKey: environmentsUserDefaultKey)
            currentEnvironment.production
            #endif
        }
        
        log("Current Environment: \(currentEnvironment?.rawValue ?? "NIL ENV")", priority: .medium)
        
        return currentEnvironment ?? Environment.production
    }
    
    static func switchEnvironments(to environment: Environment) {
        guard environment != currentEnvironment else { return }
        
        #if !RELEASE
        UserDefaults.fromContainer.set(environment.rawValue, forKey: environmentsUserDefaultKey)
        log("Switching environment to \(environment) and terminating", priority: .high)
        abort()
        #endif
    }
}


//enum Environments: String, EnvironmentOption {
//    case development
//    case staging
//    case production
//}
//
// HelperConfig gets Environment Config which takes an enum type
// declared in project
//struct EnvironmentConfig<T> {
//    let type: T.Type
//    let releaseEnvironment: EnvironmentOption
//    let defaultDebugEnvironment: EnvironmentOption
//}
//
//protocol EnvironmentOption {
//    var rawValue: String { get }
//    init(rawValue: String)
//}
//
//class Environment {
//
//    static let environmentsUserDefaultKey = "environmentsUserDefaultKey"
//    static var currentEnvironment: EnvironmentOption?
//    static var environmentProvider: EnvironmentConfig?
//
//    static var current: EnvironmentOption {
//        #if RELEASE
//        return Environment.production
//        #else
//        return Environment.currentEnvironment ?? environmentFromUserDefaults()
//        #endif
//    }
//
//    private static func environmentFromUserDefaults() -> EnvironmentOption {
//        if let environmentName = UserDefaults.fromContainer.string(forKey: Environment.environmentsUserDefaultKey) {
//            currentEnvironment = Environment(rawValue: environmentName)
//        } else {
//            #if DEBUG
//            UserDefaults.fromContainer.set(Environment.development.rawValue, forKey: environmentsUserDefaultKey)
//            currentEnvironment = .development
//            #else
//            UserDefaults.fromContainer.set(Environment.production.rawValue, forKey: environmentsUserDefaultKey)
//            currentEnvironment.production
//            #endif
//        }
//
//        log("Current Environment: \(currentEnvironment?.rawValue ?? "NIL ENV")", priority: .medium)
//
//        return currentEnvironment ?? Environment.production
//    }
//
//    static func switchEnvironments(to environment: EnvironmentOption) {
//        guard environment != currentEnvironment else { return }
//
//        #if !RELEASE
//        UserDefaults.fromContainer.set(environment.rawValue, forKey: environmentsUserDefaultKey)
//        log("Switching environment to \(environment) and terminating", priority: .high)
//        abort()
//        #endif
//    }
//}
