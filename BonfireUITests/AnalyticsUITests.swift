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

    func testValidNumberOfTiles() {
        let numberTiles = app?.otherElements.matching(identifier: "tile").count
        XCTAssertEqual(numberTiles, 5)
    }

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
        XCTAssertEqual(cprLabel, "$0.0")
    }
    
    func testRotate() {
        // Testing wether elements are still correct in landscape (as this scene uses addaptive layout)
        XCUIDevice.shared.orientation = .landscapeLeft
        testValidTileContent()
        testValidNumberOfTiles()
    }
    
    func configureMockServer() {
        // Specifying routes that will be required for this scene
        mockServer.addRoute(route: "zones", jsonData: MockData().zoneData, requestType: .get)
        mockServer.addRoute(route: "zones/023e105f4ecef8ad9ca31a8372d0c353/analytics/dashboard", jsonData: MockData().analyticsData, requestType: .get)
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
