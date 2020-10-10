//
//  AnalyticsUITests.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 3/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest

class AnalyticsUITests: XCTestCase {
    
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
    }

    override func tearDown() {
        super.tearDown()
        mockServer.server.stop()
    }

    /**
     Tests whether the correct number of tiles are presented
     */
    func testValidNumberOfTiles() {
        let numberTiles = app?.otherElements.matching(identifier: "tile").count
        XCTAssertEqual(numberTiles, 5)
    }

    /**
     Tests whether the data presented in each tile matches the mock data provided
     */
    func testValidTileContent() {
        let pageviewsLabel = app?.staticTexts.element(matching: .any, identifier: "pageviewsLabel").label
        XCTAssertEqual(pageviewsLabel, "5724723")
        
        let threatsLabel = app?.staticTexts.element(matching: .any, identifier: "threatsLabel").label
        XCTAssertEqual(threatsLabel, "23423873")

        let cachedLabel = app?.staticTexts.element(matching: .any, identifier: "cachedLabel").label
        XCTAssertEqual(cachedLabel, "750")

        let uncachedLabel = app?.staticTexts.element(matching: .any, identifier: "uncachedLabel").label
        XCTAssertEqual(uncachedLabel, "1250")

        let percentCachedLabel = app?.staticTexts.element(matching: .any, identifier: "percentCachedLabel").label
        XCTAssertEqual(percentCachedLabel, "37.5%")

        let cpmLabel = app?.staticTexts.element(matching: .any, identifier: "cpmLabel").label
        XCTAssertEqual(cpmLabel, "$0.0")

        let cprLabel = app?.staticTexts.element(matching: .any, identifier: "cprLabel").label
        XCTAssertEqual(cprLabel, "$0.0025")
    }

    /**
     Testing whether elements are still correct when the device is placed in landscape (as this scene uses addaptive layout)
     */
    func testRotate() {
        XCUIDevice.shared.orientation = .landscapeLeft
        testValidTileContent()
        testValidNumberOfTiles()
    }

    /**
     Specifies the routes that will be required to test this scene
     */
    func configureMockServer() {
        mockServer.addRoute(route: "zones", jsonData: MockData().zoneData, requestType: .get)
        mockServer.addRoute(route: "zones/023e105f4ecef8ad9ca31a8372d0c353/analytics/dashboard", jsonData: MockData().analyticsData, requestType: .get)
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
