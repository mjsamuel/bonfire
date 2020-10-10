//
//  ActionTests.swift
//  BonfireTests
//
//  Created by Matthew Samuel on 3/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest
@testable import Bonfire

class ActionTests: XCTestCase {
    
    var action: Action?

    override func setUp() {
        super.setUp()
        action = nil
    }

    override func tearDown() {
        super.tearDown()
    }
    
    /**
     Tests that an action when created via a rawValue is the correct action
     */
    func testRawValues() {
        action = Action(rawValue: "Allow")
        XCTAssertEqual(action, Action.allow)
        
        action = Action(rawValue: "JS challenge")
        XCTAssertEqual(action, Action.JSchallange)
        
        action = Action(rawValue: "CAPTCHA challenge")
        XCTAssertEqual(action, Action.CAPTCHAchallange)
        
        action = Action(rawValue: "Ban")
        XCTAssertEqual(action, Action.ban)
        
        action = Action(rawValue: "Default")
        XCTAssertEqual(action, Action.normal)
    }
    
    /**
     Tests that every action has a description associated with it
     */
    func testGetDescription() {
        XCTAssertNotNil(Action.allow.description)
        XCTAssertNotNil(Action.JSchallange.description)
        XCTAssertNotNil(Action.CAPTCHAchallange.description)
        XCTAssertNotNil(Action.ban.description)
        XCTAssertNotNil(Action.normal.description)
    }

}
