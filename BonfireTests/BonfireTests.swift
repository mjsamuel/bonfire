//
//  BonfireTests.swift
//  BonfireTests
//
//  Created by Matthew Samuel on 8/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest

@testable import Bonfire

class BonfireTests: XCTestCase {

    let mockServer: MockServer = MockServer()
    var bonfire: Bonfire?
    
    override func setUp() {
        super.setUp()
        
        configureMockServer()
        try! mockServer.server.start()
        
        bonfire = Bonfire.sharedInstance
    }

    override func tearDown() {
        super.tearDown()
        bonfire?.reset()
        mockServer.server.stop()
        
    }
    
    /**
     Tests that the login method updates the state accordingly if successfull
     */
    func testSuccessfulLogin() {
        // Pre-conditions
        XCTAssertFalse(bonfire?.cloudflare?.isLoggedIn ?? true)
        XCTAssertNil(bonfire?.zones)
        XCTAssertNil(bonfire?.currentZone)
        
        // Logging in the user
        let expectation = self.expectation(description: "Logging in user")
        bonfire?.login(email: "john_doe@gmail.com", apiKey: "023e105f4ecef8ad9ca31a8372d0c353", completion: {success in
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10)

        // Post-conditions
        XCTAssertTrue((bonfire?.cloudflare?.isLoggedIn)!)
        XCTAssertNotNil(bonfire?.zones)
        XCTAssertNotNil(bonfire?.currentZone)
    }
    
    /**
     Tests that the state of the Bonfire singelton does not change when a failed login occurs
     */
    func testFailedLogin() {
        // Changing the mock server's login route to return an empty response to trigger a failed login condition
        mockServer.addRoute(route: "zones", jsonData: "{}".data(using: .utf8)!, requestType: .get)
        
        // Pre-conditions
        XCTAssertFalse(bonfire?.cloudflare?.isLoggedIn ?? true)
        XCTAssertNil(bonfire?.zones)
        XCTAssertNil(bonfire?.currentZone)
        
        // Attempting to login the user
        let expectation = self.expectation(description: "Logging in user")
        bonfire?.login(email: "john_doe@gmail.com", apiKey: "023e105f4ecef8ad9ca31a8372d0c353", completion: {success in
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10)
        
        // Post-conditions: Making sure the variables are unchanged
        XCTAssertFalse((bonfire?.cloudflare?.isLoggedIn)!)
        XCTAssertNil(bonfire?.zones)
        XCTAssertNil(bonfire?.currentZone)
    }
    
    func testLogout() {
        // Logging in user
        testSuccessfulLogin()
        
        // Pre-conditions
        XCTAssertTrue((bonfire?.cloudflare?.isLoggedIn)!)
        XCTAssertNotNil(bonfire?.zones)
        XCTAssertNotNil(bonfire?.currentZone)
        
        bonfire?.logout()

        // Post-conditions
        XCTAssertNil(bonfire?.cloudflare)
        XCTAssertNil(bonfire?.zones)
        XCTAssertNil(bonfire?.currentZone)
    }
    
    /**
     Specifies the routes that will be required to test this scene
     */
    func configureMockServer() {
        mockServer.addRoute(route: "zones", jsonData: MockData().zoneData, requestType: .get)
    }

}

extension Bonfire {
    /**
     Allows for the Bonfire singleton to be reset in between tests
     */
    func reset() {
        cloudflare = Cloudflare(email: "...", apiKey: "...")
        zones = nil
        currentZone = nil
    }
}
