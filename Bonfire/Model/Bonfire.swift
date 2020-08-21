//
//  Bonfire.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

class Bonfire {
    static let sharedInstance = Bonfire()
    
    public var cloudflare: Cloudflare?
    public var zones: [Zone]?
    public var currentZone: Zone?

    private init() {
        cloudflare = nil
        zones = nil
        currentZone = nil
    }
    
    public func login(email: String, apiKey: String) {
        cloudflare = Cloudflare(email: email, apiKey: apiKey)
        zones = cloudflare?.getZones()
        currentZone = zones?[0]
    }
    
    public func logout() {
        cloudflare = nil
    }
    
    public func setCurrentZone() {
        
    }
    
}
