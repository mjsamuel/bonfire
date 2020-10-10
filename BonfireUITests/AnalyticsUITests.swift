//
//  AnalyticsUITests.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 3/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest
import Swifter

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
        
        login()
    }

    override func tearDown() {
        super.tearDown()
        mockServer.server.stop()
    }

    func testNumberOfTiles() {
        let numberTiles = app?.otherElements.matching(identifier: "tile").count
        XCTAssertEqual(numberTiles, 5)
    }

    func testTileContent() {
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
        XCTAssertEqual(cpmLabel, "$20.0")

        let cprLabel = app?.staticTexts.element(matching: .any, identifier: "cprLabel").label
        XCTAssertEqual(cprLabel, "$0.01")
    }

    func testRefreshData() {
        
    }
    
    func testRotate() {
        XCUIDevice.shared.orientation = .landscapeLeft
        testTileContent()
        testNumberOfTiles()
    }
    
    func configureMockServer() {
        let data: Data = """
            {
              "success": true,
              "errors": [],
              "messages": [],
              "result": [
                {
                  "id": "023e105f4ecef8ad9ca31a8372d0c353",
                  "name": "example.com",
                  "development_mode": 7200,
                  "original_name_servers": [
                    "ns1.originaldnshost.com",
                    "ns2.originaldnshost.com"
                  ],
                  "original_registrar": "GoDaddy",
                  "original_dnshost": "NameCheap",
                  "created_on": "2014-01-01T05:20:00.12345Z",
                  "modified_on": "2014-01-01T05:20:00.12345Z",
                  "activated_on": "2014-01-02T00:01:00.12345Z",
                  "owner": {
                    "id": {},
                    "email": {},
                    "type": "user"
                  },
                  "account": {
                    "id": "01a7362d577a6c3019a474fd6f485823",
                    "name": "Demo Account"
                  },
                  "permissions": [
                    "#zone:read",
                    "#zone:edit"
                  ],
                  "plan": {
                    "id": "e592fd9519420ba7405e1307bff33214",
                    "name": "Pro Plan",
                    "price": 20,
                    "currency": "USD",
                    "frequency": "monthly",
                    "legacy_id": "pro",
                    "is_subscribed": true,
                    "can_subscribe": true
                  },
                  "plan_pending": {
                    "id": "e592fd9519420ba7405e1307bff33214",
                    "name": "Pro Plan",
                    "price": 20,
                    "currency": "USD",
                    "frequency": "monthly",
                    "legacy_id": "pro",
                    "is_subscribed": true,
                    "can_subscribe": true
                  },
                  "status": "active",
                  "paused": false,
                  "type": "full",
                  "name_servers": [
                    "tony.ns.cloudflare.com",
                    "woz.ns.cloudflare.com"
                  ]
                }
              ]
            }
        """.data(using: .utf8)!
        
        mockServer.addRoute(route: "zones", jsonData: data, requestType: .get)
    }
    
    func login() {
        let emailField = app?.textFields["emailField"]
        emailField?.tap()
        emailField?.typeText("test\n")
        
        let apiKeyField = app?.textFields["apiKeyField"]
        apiKeyField?.tap()
        apiKeyField?.typeText("test\n")
        
        sleep(2)
    }

}
