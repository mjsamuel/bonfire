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
        
        // Launching the app and specificying that it should be run with a mock server
        app = XCUIApplication()
        app?.launchArguments = ["USE_MOCK_SERVER"]
        app?.launch()
        
        XCUIDevice.shared.orientation = .portrait
        
        login()
        
        // Selecting the Requests scene from the tab bar
        let tabItem = app?.tabBars.firstMatch.buttons.element(boundBy: 1)
        tabItem?.tap()
        
        sleep(1)
    }
    
    override func tearDown() {
        super.tearDown()
        mockServer.server.stop()
    }
    
    /**
     Tests whether the ammount of cells presented match the number of mock requests provided
     */
    func testValidNumberOfRequests() {
        let numberRequests = app?.tables.cells.count
        XCTAssertEqual(numberRequests, 5)
    }

    /**
     Tests whether the data in cells that are presented match the mock data provided
     */
    func testValidCellData() {
        // Looping through every table cell
        let numberRequests = app?.tables.cells.count
        for i in 0...numberRequests! - 1 {
            let dnsCell = app?.tables.cells.element(boundBy: i)
            let label = dnsCell?.staticTexts.element(boundBy: 0).label
            
            let expextedText: String
            
            switch i {
            case 1:
                expextedText = "log - 203.0.113.69 (GB)"
            case 2:
                expextedText = "post - 203.0.113.233 (US)"
            case 3:
                expextedText = "get - 203.0.113.233 (US)"
            case 4:
                expextedText = "allow - 2001:8003:d4c0:5f00:62a4:4cff:fe5c:b8e0 (AU)"
            default:
                expextedText = "get - 220.253.122.100 (AU)"
            }
            
            XCTAssertEqual(label, expextedText)
        }
    }
    
    /**
     Tests that the correct alert is shown when banning a request
     */
    func testBanRequest() {
        app?.tables.cells.element(boundBy: 0).tap()
        app?.sheets.buttons["Ban"].tap()
        
        let alertLabel = app?.alerts.element.label
        XCTAssertTrue(alertLabel?.contains("block") ?? false)
    }
    
    /**
     Tests that the correct alert is shown when JS challenging a request
     */
    func testJsChallengeRequest() {
        app?.tables.cells.element(boundBy: 0).tap()
        app?.sheets.buttons["JS Challenge"].tap()
        
        let alertLabel = app?.alerts.element.label
        XCTAssertTrue(alertLabel?.contains("js_challenge") ?? false)
    }
    
    /**
     Tests that the correct alert is shown when allowing a request
     */
    func testAllowRequest() {
        app?.tables.cells.element(boundBy: 0).tap()
        app?.sheets.buttons["Allow"].tap()
        
        let alertLabel = app?.alerts.element.label
        XCTAssertTrue(alertLabel?.contains("whitelist") ?? false)
    }
    
    /**
     Tests that the correct alert is shown when captcha challenging a request
     */
    func testCaptchaChallengeRequest() {
        app?.tables.cells.element(boundBy: 0).tap()
        app?.sheets.buttons["CAPTCHA Challenge"].tap()
        
        let alertLabel = app?.alerts.element.label
        XCTAssertTrue(alertLabel?.contains("CAPTCHA Challenge") ?? false)
    }
    
    /**
     Specifies the routes that will be required to test this scene
     */
    func configureMockServer() {
        mockServer.addRoute(route: "zones", jsonData: MockData().zoneData, requestType: .get)
        mockServer.addRoute(route: "graphql", jsonData: MockData().requestsData, requestType: .post)
    }

    /**
     Helper method to automate going through the login page
     */
    func login() {
        let emailField = app?.textFields["emailField"]
        emailField?.tap()
        emailField?.typeText("test\n")
        
        let apiKeyField = app?.textFields["apiKeyField"]
        apiKeyField?.tap()
        apiKeyField?.typeText("test\n")
        
        sleep(1)
    }

}
