//
//  DnsUITestts.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 5/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest

class RequestsUITests: XCTestCase {

    let mockServer: MockServer = MockServer()
    var app: XCUIApplication?
    
    override func setUp() {
        continueAfterFailure = false
        
        configureMockServer()
        try! mockServer.server.start()
        
        app = XCUIApplication()
        app?.launchArguments = ["USE_MOCK_SERVER"]
        app?.launch()
        
        XCUIDevice.shared.orientation = .portrait
        
        login()
        
        // Selecting the Requests scene from the tab bar
        let tabItem = app?.tabBars.firstMatch.buttons.element(boundBy: 1)
        tabItem?.tap()
    }
    
    override func tearDown() {
        super.tearDown()
        mockServer.server.stop()
    }

    func testValidNumberOfRequests() {
        sleep(1)
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
    
    func configureMockServer() {
        // Specifying routes that will be required for this scene
        mockServer.addRoute(route: "zones", jsonData: MockData().zoneData, requestType: .get)
        mockServer.addRoute(route: "graphql", jsonData: MockData().requestsData, requestType: .post)
    }

    func login() {
        // Helper method to automate going through the login page
        let emailField = app?.textFields["emailField"]
        emailField?.tap()
        emailField?.typeText("test\n")
        
        let apiKeyField = app?.textFields["apiKeyField"]
        apiKeyField?.tap()
        apiKeyField?.typeText("test\n")
        
        sleep(1)

    }

}
