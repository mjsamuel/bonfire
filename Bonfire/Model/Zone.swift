//
//  Zone.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

struct Zone {
    
    private let id: String
    public var name: String
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    public func getId() -> String {
        return self.id
    }
    
}
