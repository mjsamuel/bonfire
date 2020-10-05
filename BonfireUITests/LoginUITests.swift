//
//  LoginUITests.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 5/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest

class LoginUITests: XCTestCase {

    var app: XCUIApplication?
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        XCUIApplication().launch()
        XCUIDevice.shared.orientation = .portrait
    }
    
    override func tearDown() {
        super.tearDown()
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

}
