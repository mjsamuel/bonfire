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
        cloudflare = Cloudflare(email: "...", apiKey: "...")
        zones = cloudflare?.getZones()
        currentZone = zones?[0]
    }
    
    /**
     Logs in a user with thier credentials
     
     - Parameters:
        - email: The email of the user
        - apiKey: The api key corresponding to that account
     */
    public func login(email: String, apiKey: String) {
        cloudflare = Cloudflare(email: email, apiKey: apiKey)
        zones = cloudflare?.getZones()
        currentZone = zones?[0]
    }
    
    
    /**
     Logs out a user and discards their credentials
     */
    public func logout() {
        cloudflare = nil
        zones = nil
        currentZone = nil
    }
    
    public func setCurrentZone() {
        
    }
    
}
