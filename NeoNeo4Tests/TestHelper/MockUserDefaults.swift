//
//  MockUserDefaults.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
@testable import NeoNeo4

class MockUserDefaults: UserDefaultable {
    
    func string(forKey: String) -> String? {
        storedItems[forKey] as? String
    }
    
    func set(_ value: Any?, forKey: String) {
        storedItems[forKey] = value
    }
    
    private var storedItems: [String: Any?] = [:]
}
