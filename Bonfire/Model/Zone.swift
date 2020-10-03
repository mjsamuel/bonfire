//
//  Zone.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

/**
 Struct to represent a Zone
 */
struct Zone: Equatable {
    
    private let id: String
    public var name: String
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    public func getId() -> String {
        return self.id
    }

    static func == (lhs: Zone, rhs: Zone) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
}
