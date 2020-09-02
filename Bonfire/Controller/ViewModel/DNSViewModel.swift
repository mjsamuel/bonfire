//
//  DNSViewModel.swift
//  Bonfire
//
//  Created by Dylan Sbogar on 29/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

struct DNSViewModel {
    private let bonfire: Bonfire = Bonfire.sharedInstance
    private var DNSdata: [[String: Any]] = []
    
    init() {
        updateData()
    }
    
    /**
     Pulls data from the Cloudflare API
     */
    public mutating func updateData() {
        let zoneId = bonfire.currentZone!.getId()
        if let rawDNS = bonfire.cloudflare!.getRequests(zoneId: zoneId) {
            self.DNSdata = rawDNS
        }
    }
}

struct DNS {
    let name: String
    let content: String
    let type: String
}
