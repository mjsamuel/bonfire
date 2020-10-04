//
//  AnalyticsUITests.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 3/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest

class AnalyticsUITests: XCTestCase {
    
    var app: XCUIApplication?
    
    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
//        app?.launchEnvironment["-FakedFeedResponse"] = "success.json"
        XCUIApplication().launch()
        XCUIDevice.shared.orientation = .portrait
        
        login()
    }

    override func tearDown() {
        super.tearDown()
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
