//
//  LoginUITests.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 5/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest

class LoginUITests: XCTestCase {

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
    }
    
    override func tearDown() {
        super.tearDown()
        mockServer.server.stop()
    }
    
    func testValidScene() {
        let emailField = app?.textFields["emailField"]
        XCTAssertTrue(emailField?.exists ?? false)
        
        let apiKeyField = app?.textFields["apiKeyField"]
        XCTAssertTrue(apiKeyField?.exists ?? false)
    }
    
    func testLogin() {
        let emailField = app?.textFields["emailField"]
        emailField?.tap()
        emailField?.typeText("test\n")
        
        let apiKeyField = app?.textFields["apiKeyField"]
        apiKeyField?.tap()
        apiKeyField?.typeText("test\n")
        
        XCTAssertFalse(emailField?.exists ?? false)
        XCTAssertFalse(apiKeyField?.exists ?? false)
    }

    func configureMockServer() {
        // Specifying routes that will be required for this scene
        mockServer.addRoute(route: "zones", jsonData: MockData().zoneData, requestType: .get)
    }
}
