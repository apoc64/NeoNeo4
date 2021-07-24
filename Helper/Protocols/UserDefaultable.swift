//
//  UserDefaultable.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

protocol UserDefaultable {
    func string(forKey: String) -> String?
    func bool(forKey: String) -> Bool
    func integer(forKey: String) -> Int
    func object(forKey: String) -> Any?
    func set(_ value: Any?, forKey: String)
}

extension UserDefaults: UserDefaultable {
    
    static var fromContainer: UserDefaultable {
        Container.resolve(UserDefaultable.self) ?? UserDefaults.standard
    }
}
