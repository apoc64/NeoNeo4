//
//  Notification+Extension.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 7/24/21.
//

import Foundation

enum NotificationName: String {
    case userSettingsReset
}

typealias Notifier = Notification.Name

extension Notifier {
    init(_ name: NotificationName) {
        self.init(name.rawValue)
    }
}

extension Notification {
    init(_ name: NotificationName) {
        self.init(name: Notifier(name))
    }
}
