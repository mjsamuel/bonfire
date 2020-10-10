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

        // Launching the app and specificying that it should be run with a mock server
        app = XCUIApplication()
        app?.launchArguments = ["USE_MOCK_SERVER"]
        app?.launch()
        
        XCUIDevice.shared.orientation = .portrait
    }
    
    override func tearDown() {
        super.tearDown()
        mockServer.server.stop()
    }
    
    /**
     Test wether the login view is valid and presenting the correct fields
     */
    func testValidScene() {
        let emailField = app?.textFields["emailField"]
        XCTAssertTrue(emailField?.exists ?? false)
        
        let apiKeyField = app?.textFields["apiKeyField"]
        XCTAssertTrue(apiKeyField?.exists ?? false)
    }
    
    /**
     Test that upon a successfull login, the login page is dismissed
     */
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
    
    /**
     Specifies the routes that will be required to test this scene
     */
    func configureMockServer() {
        mockServer.addRoute(route: "zones", jsonData: MockData().zoneData, requestType: .get)
    }
}
