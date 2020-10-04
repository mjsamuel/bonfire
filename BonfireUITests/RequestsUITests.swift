//
//  DnsUITestts.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 5/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest

class RequestsUITests: XCTestCase {

    var app: XCUIApplication?

    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        XCUIApplication().launch()
        XCUIDevice.shared.orientation = .portrait
        
        login()
        
        let tabItem = app?.tabBars.firstMatch.buttons.element(boundBy: 1)
        tabItem?.tap()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNumberOfRequests() {
        let numberRequests = app?.tables.cells.count
        XCTAssertEqual(numberRequests, 5)
    }
    
    func testBanRequest() {
        app?.tables.cells.element(boundBy: 0).tap()
        app?.sheets.buttons["Ban"].tap()
        
        let alertLabel = app?.alerts.element.label
        XCTAssertTrue(alertLabel?.contains("Ban") ?? false)
    }
    
    func testJsChallengeRequest() {
        app?.tables.cells.element(boundBy: 0).tap()
        app?.sheets.buttons["JS Challenge"].tap()
        
        let alertLabel = app?.alerts.element.label
        XCTAssertTrue(alertLabel?.contains("JS challenge") ?? false)
    }
    
    func testAllowRequest() {
        app?.tables.cells.element(boundBy: 0).tap()
        app?.sheets.buttons["Allow"].tap()
        
        let alertLabel = app?.alerts.element.label
        XCTAssertTrue(alertLabel?.contains("Allow") ?? false)
    }
    
    func testCaptchaChallengeRequest() {
        app?.tables.cells.element(boundBy: 0).tap()
        app?.sheets.buttons["CAPTCHA Challenge"].tap()
        
        let alertLabel = app?.alerts.element.label
        XCTAssertTrue(alertLabel?.contains("CAPTCHA Challenge") ?? false)
    }

    func login() {
        let emailField = app?.textFields["emailField"]
        emailField?.tap()
        emailField?.typeText("test\n")
        
        let apiKeyField = app?.textFields["apiKeyField"]
        apiKeyField?.tap()
        apiKeyField?.typeText("test\n")
    }

}
