//
//  ContextProviding.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
import CoreData

protocol ContextProviding {
    var main: NSManagedObjectContext? { get }
    // Additional contexts as necessary
    // func forKey(_ key: AnyHashable) -> NSManagedObjectContext?
}

extension NSManagedObjectContext {
    static var fromContainer: ContextProviding? {
        Container.resolve(ContextProviding.self)
    }
}
