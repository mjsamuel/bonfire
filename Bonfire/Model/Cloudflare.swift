//
//  Cloudflare.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

struct Cloudflare {
    
    init(email: String, apiKey: String) {
        
    }
    
    public func getZones() -> [Zone] {
        let retVal: [Zone] = []
        
        return retVal
    }
    
    public func getAnalytics(zoneId: String) -> [String: Any] {
        let retVal: [String: Any] = [
            "Key": "Value",
            "NetedDict": []
        ]
        
        return retVal
    }
}
