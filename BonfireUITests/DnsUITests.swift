//
//  DnsUITests.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 5/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest

class DnsUITests: XCTestCase {

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
        
        // Selecting the DNS scene from the tab bar
        let tabItem = app?.tabBars.firstMatch.buttons.element(boundBy: 2)
        tabItem?.tap()
    }
    
    override func tearDown() {
        super.tearDown()
        mockServer.server.stop()
    }
    
    func testValidNumberOfRequests() {
        sleep(1)
        let numberRequests = app?.tables.cells.count
        XCTAssertEqual(numberRequests, 4)
    }
    
    func testValidCellData() {
    
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
    
    func configureMockServer() {
        // Specifying routes that will be required for this scene
        mockServer.addRoute(route: "zones", jsonData: MockData().zoneData, requestType: .get)
        mockServer.addRoute(route: "zones/023e105f4ecef8ad9ca31a8372d0c353/dns_records", jsonData: MockData().dnsData, requestType: .get)
        mockServer.addRoute(route: "zones/023e105f4ecef8ad9ca31a8372d0c353/dns_records/372e67954025e0ba6aaa6d586b9e0b59", jsonData: MockData().updateDnsResponse, requestType: .put)
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
