//
//  ZoneTests.swift
//  BonfireTests
//
//  Created by Matthew Samuel on 3/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest
@testable import Bonfire

class ZoneTests: XCTestCase {

    let ZONE_NAME: String = "example.com"
    let ZONE_ID: String = "023e105f4ecef8ad9ca31a8372d0c353"
    
    var zone: Zone?
    
    override func setUp() {
        super.setUp()
        zone = Zone(name: ZONE_NAME, id: ZONE_ID)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    /**
     Tests that when a zone is instantiated it is valid
     */
    func testValidZone() {
        let expectedZone: Zone = Zone(name: ZONE_NAME, id: ZONE_ID)
        
        XCTAssertNotNil(zone?.name)
        XCTAssertNotNil(zone?.getId())
        
        XCTAssertEqual(zone?.name, expectedZone.name)
        XCTAssertEqual(zone?.getId(), expectedZone.getId())
    }
    
    func testGetId() {
        XCTAssertEqual(zone?.getId(), ZONE_ID)
    }
    
}
