//
//  DnsUITests.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 5/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest

class DnsUITests: XCTestCase {

    var app: XCUIApplication?
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        XCUIApplication().launch()
        XCUIDevice.shared.orientation = .portrait
        
        login()
        
        let tabItem = app?.tabBars.firstMatch.buttons.element(boundBy: 2)
        tabItem?.tap()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfRequests() {
        let numberRequests = app?.tables.cells.count
        XCTAssertEqual(numberRequests, 4)
    }
    
    func testModifyDNS() {
        let dnsCell = app?.tables.cells.element(boundBy: 0)
        var cellLabel = dnsCell?.staticTexts.element(boundBy: 1).label
        XCTAssertEqual(cellLabel, "198.51.100.4")
        
        dnsCell?.tap()
        
        let contentTextField = app?.textFields.element(boundBy: 0)
        contentTextField?.tap()
        contentTextField?.typeText(XCUIKeyboardKey.delete.rawValue)
        contentTextField?.typeText("2\n")
        
        app?.navigationBars.buttons["Save"].tap()
        
        cellLabel = dnsCell?.staticTexts.element(boundBy: 1).label
        XCTAssertEqual(cellLabel, "198.51.100.2")
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
