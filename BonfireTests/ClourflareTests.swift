//
//  ClourflareTests.swift
//  BonfireTests
//
//  Created by Matthew Samuel on 3/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest
@testable import Bonfire

class ClourflareTests: XCTestCase {

    var cloudFlare: Cloudflare?
    
    override func setUp() {
        super.setUp()
        cloudFlare = Cloudflare(email: "", apiKey: "")
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testGetZones() {
        let expectedData: [Zone] = [
            Zone(name: "example.com", id: "023e105f4ecef8ad9ca31a8372d0c353"),
            Zone(name: "test.com", id: "353c0d2738a13ac9da8fece4f501e320"),
            Zone(name: "a.site", id: "853e105f4ecef8ad9ca31a8372d0c432")
        ]
        
//        let zones: [Zone] = cloudFlare?.getZones() ?? []
//
//        for i in 0...zones.count - 1 {
//            XCTAssertEqual(zones[i], expectedData[i])
//        }
    }
    
}
