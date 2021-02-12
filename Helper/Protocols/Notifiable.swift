//
//  Notifiable.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

protocol Notifiable {
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?)
    func post(_ notification: Notification)
}

extension NotificationCenter:Notifiable {
    static var fromContainer: Notifiable {
        Container.resolve(Notifiable.self) ?? NotificationCenter.default
    }
}
