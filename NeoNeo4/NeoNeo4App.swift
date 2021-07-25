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
            analyticsProviding: NoAnalytics())
        
        Helper.configure(config)
        
        configureAppearance()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainTabBarView()
        }
    }
    
    private func configureAppearance() {
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0, green: 250, blue: 100, alpha: 1)
    }
}
