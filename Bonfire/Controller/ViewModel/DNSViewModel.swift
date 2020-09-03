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
    private var dnsRecords: [[String: Any]] = []
    
    init() {
        updateData()
    }
    
    public mutating func updateData() {
        let zoneId = bonfire.currentZone!.getId()
        if let rawDNS = bonfire.cloudflare!.getRequests(zoneId: zoneId) {
            self.dnsRecords = rawDNS
        }
    }
    
    public func getDNS() -> [DNS] {
        var dnsListings: [DNS] = []
        for dnsListing in dnsRecords {
            if let name = dnsListing["name"] as? String,
                let type = dnsListing["type"] as? String
            {
                let dnsRecord: DNS = DNS(
                name: name,
                type: type)

                dnsListings.append(dnsRecord)
            }
            
        }
        return dnsListings
    }
}

struct DNS {
    let name: String
    let type: String
}

// TOP PRIORITY: CLEAN UP CODE NAMING CONVENTIONS FOR DNSLISTING and DNSRECORDS variables and those like it.
