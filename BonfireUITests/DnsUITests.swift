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
        
        // Launching the app and specificying that it should be run with a mock server
        app = XCUIApplication()
        app?.launchArguments = ["USE_MOCK_SERVER"]
        app?.launch()
        
        XCUIDevice.shared.orientation = .portrait
        
        login()
        
        // Selecting the DNS scene from the tab bar
        let tabItem = app?.tabBars.firstMatch.buttons.element(boundBy: 2)
        tabItem?.tap()
        
        sleep(1)
    }
    
    override func tearDown() {
        super.tearDown()
        mockServer.server.stop()
    }
    
    /**
     Tests whether the ammount of cells presented match the number of mock records provided
     */
    func testValidNumberOfRequests() {
        let numberRequests = app?.tables.cells.count
        XCTAssertEqual(numberRequests, 1)
    }
    
    /**
     Tests whether the data in cells that are presented match the mock data provided
     */
    func testValidCellData() {
        // Looping through every table cell
        let numberRequests = app?.tables.cells.count
        for i in 0...numberRequests! - 1 {
            let dnsCell = app?.tables.cells.element(boundBy: i)
            let nameLabel = dnsCell?.staticTexts.element(boundBy: 0).label
            let ipLabel = dnsCell?.staticTexts.element(boundBy: 1).label
            
            let expextedName: String
            let expextedLabel: String
            
            switch i {
            case 1:
                expextedName = "google.com"
                expextedLabel = "216.58.200.110"
            case 2:
                expextedName = "instagram.com"
                expextedLabel = "52.22.200.157"
            case 3:
                expextedName = "rmit.edu.au"
                expextedLabel = "131.170.0.105"
            default:
                expextedName = "example.com"
                expextedLabel = "198.51.100.4"
            }
            
            XCTAssertEqual(nameLabel, expextedName)
            XCTAssertEqual(ipLabel, expextedLabel)
        }
    }
    
    /**
     Test whether modifying a DNS record will update the table view, spanning multiple scenes
     */
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
    
    /**
     Specifies the routes that will be required to test this scene
     */
    func configureMockServer() {
        mockServer.addRoute(route: "zones", jsonData: MockData().zoneData, requestType: .get)
        mockServer.addRoute(route: "zones/023e105f4ecef8ad9ca31a8372d0c353/dns_records", jsonData: MockData().dnsData, requestType: .get)
        mockServer.addRoute(route: "zones/023e105f4ecef8ad9ca31a8372d0c353/dns_records/372e67954025e0ba6aaa6d586b9e0b59", jsonData: MockData().updateDnsResponse, requestType: .put)
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
