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

    let mockServer: MockServer = MockServer()
    var cloudflare: Cloudflare?

    override func setUp() {
        super.setUp()

        configureMockServer()
        try! mockServer.server.start()

        cloudflare = Cloudflare(email: "test", apiKey: "test")

        sleep(3)
    }

    override func tearDown() {
        super.tearDown()
        mockServer.server.stop()
    }
    
    /**
     Tests that JSON data is proccessed appropriately by the getZones() method and outputs an array of zones that atch the mock data
     */
    func testGetZones() {
        let expectedData: [Zone] = [
            Zone(name: "example.com", id: "023e105f4ecef8ad9ca31a8372d0c353")
        ]
        var receivedZones: [Zone] = []

        let expectation = self.expectation(description: "Retrieving zones")
        cloudflare?.getZones(completion: { zones in
            receivedZones = zones
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10)

        for i in 0...expectedData.count - 1 {
            XCTAssertEqual(receivedZones[i], expectedData[i])
        }
    }
    
    /**
     Specifies the routes that will be required to test this scene
     */
    func configureMockServer() {
        mockServer.addRoute(route: "zones", jsonData: MockData().zoneData, requestType: .get)
    }

}
