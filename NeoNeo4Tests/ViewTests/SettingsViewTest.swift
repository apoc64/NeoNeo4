//
//  SettingsViewTest.swift
//  NeoNeo4Tests
//
//  Created by Steve Schwedt on 7/24/21.
//

import XCTest
@testable import NeoNeo4

class SettingsViewTest: XCTestCase {

    func testExample() throws {
        UserSettingsHelpers.setMockUserDefaults()
        let view = SettingsView()
        let model = view.model

        XCTAssertEqual(model.username, "Bob")
        XCTAssertEqual(model.isPrivate, false)
        XCTAssertEqual(model.notificationsEnabled, true)
        XCTAssertEqual(model.previewIndex, 2)
        XCTAssertEqual(model.previewOptions[model.previewIndex], "Never")
        
        view.resetAllSettings()
        
        XCTAssertEqual(model.username, "")
        XCTAssertEqual(model.isPrivate, true)
        XCTAssertEqual(model.notificationsEnabled, false)
        XCTAssertEqual(model.previewIndex, 0)
        XCTAssertEqual(model.previewOptions[model.previewIndex], "Always")
    }
}
