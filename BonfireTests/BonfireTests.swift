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

    var bonfire: Bonfire?
    
    override func setUp() {
        super.setUp()
        bonfire = Bonfire.sharedInstance
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testLogin() {
//        bonfire?.login(email: "john_doe@gmail.com", apiKey: "023e105f4ecef8ad9ca31a8372d0c353")
//        
//        XCTAssertNotNil(bonfire?.cloudflare)
//        XCTAssertTrue((bonfire?.cloudflare?.isLoggedIn)!)
//        XCTAssertNotNil(bonfire?.zones)
//        XCTAssertNotNil(bonfire?.currentZone)
    }
    
    func testLogout() {
        bonfire?.logout()

        XCTAssertNil(bonfire?.cloudflare)
        XCTAssertNil(bonfire?.zones)
        XCTAssertNil(bonfire?.currentZone)
    }

}
