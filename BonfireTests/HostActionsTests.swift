//
//  HostActionsTests.swift
//  BonfireTests
//
//  Created by Matthew Samuel on 3/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import XCTest
@testable import Bonfire

class HostActionsTests: XCTestCase {
    
    var hostAction: HostAction?
    
    override func setUp() {
        super.setUp()
        
        hostAction = HostAction(action: Action.allow, hostIP: "192.168.1.1")
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSetAction() {
//        hostAction?.setAction(selectedAction: Action.ban)
//        XCTAssertEqual(hostAction?.getAction(), Action.ban)
    }
    
    func testSendActionToCloudFlare() {

    }

}
