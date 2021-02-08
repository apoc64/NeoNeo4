//
//  NeoNeo4App.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/7/21.
//

import SwiftUI

@main
struct NeoNeo4App: App {
    
    init() {
        let config = HelperConfig(
            loggingPriority: .high,
            dataTaskPublisher: URLSession.shared,
            userDefaultable: UserDefaults.standard,
            notifiable: NotificationCenter.default,
            analyticsProviding: NoAnalytics())
        
        Helper.configure(config)
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainTabBarView()
        }
    }
}
