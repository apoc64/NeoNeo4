//
//  MockNotificationCenter.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
@testable import NeoNeo4

class MockNotificationCenter: Notifiable {
    
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        guard let name = name else { return }
        
        var existing = observers[name] ?? []
        existing.append(NotificationTarget(observer: observer, selector: selector))
        observers[name] = existing
    }
    
    func post(_ notification: Notification) {
        let targets = observers[notification.name]
        
        targets?.forEach {
            $0.performAction()
        }
    }
    
    private var observers: [Notification.Name: [NotificationTarget]] = [:]
}

fileprivate struct NotificationTarget {
    let observer: Any
    let selector: Selector
    
    func performAction() {
        let observedObject = observer as AnyObject
        
        _ = observedObject.perform(selector)
    }
}
