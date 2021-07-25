//
//  UserSettingsTests.swift
//  NeoNeo4Tests
//
//  Created by Steve Schwedt on 7/24/21.
//

import XCTest
@testable import NeoNeo4

class UserSettingsTests: XCTestCase {
    
    func testDefaultValues() {
        let settings = UserSettings()
        
        XCTAssertEqual(settings.username, "")
        XCTAssertEqual(settings.isPrivate, true)
        XCTAssertEqual(settings.notificationsEnabled, false)
        XCTAssertEqual(settings.previewIndex, 0)
        XCTAssertEqual(settings.previewOptions[settings.previewIndex], "Always")
    }
    
    func testNonDefaultValues() {
        setMockUserDefaults()
        let settings = UserSettings()
        
        XCTAssertEqual(settings.username, "Bob")
        XCTAssertEqual(settings.isPrivate, false)
        XCTAssertEqual(settings.notificationsEnabled, true)
        XCTAssertEqual(settings.previewIndex, 2)
        XCTAssertEqual(settings.previewOptions[settings.previewIndex], "Never")
    }
    
    func testResetAllSettings() {
        setMockUserDefaults()
        let settings = UserSettings()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification), name: Notifier(.userSettingsReset), object: nil)

        XCTAssertEqual(didReceiveResetSettingsNotification, false)
        settings.resetAllSettings()
        
        XCTAssertEqual(settings.username, "")
        XCTAssertEqual(settings.isPrivate, true)
        XCTAssertEqual(settings.notificationsEnabled, false)
        XCTAssertEqual(settings.previewIndex, 0)
        XCTAssertEqual(settings.previewOptions[settings.previewIndex], "Always")
        
        let defaults = UserDefaults.fromContainer
        let keys = UserSettingsKeys.defaultKeys
        
        XCTAssertEqual(defaults.string(forKey: keys.userNameKey), "")
        XCTAssertEqual(defaults.bool(forKey: keys.isPrivateKey), true)
        XCTAssertEqual(defaults.bool(forKey: keys.notificationsEnabledKey), false)
        XCTAssertEqual(defaults.integer(forKey: keys.isPrivateKey), 0)
        
        XCTAssertEqual(self.didReceiveResetSettingsNotification, true)
    }
    
    private var didReceiveResetSettingsNotification = false
    
    private func setMockUserDefaults() {
        let keys = UserSettingsKeys.defaultKeys
        
        UserDefaults.fromContainer.set("Bob", forKey: keys.userNameKey)
        UserDefaults.fromContainer.set(false, forKey: keys.isPrivateKey)
        UserDefaults.fromContainer.set(true, forKey: keys.notificationsEnabledKey)
        UserDefaults.fromContainer.set(2, forKey: keys.previewOptionKey)
    }
    
    @objc private func receiveNotification() {
        didReceiveResetSettingsNotification = true
    }
}
