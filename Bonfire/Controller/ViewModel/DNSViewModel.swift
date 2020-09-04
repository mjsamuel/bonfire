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
    private var dnsData: [[String: Any]] = []
    
    init() {
        updateData()
    }
    
    // Pulls data from Cloudflare API
    public mutating func updateData() {
        let zoneId = bonfire.currentZone!.getId()
        if let rawDNS = bonfire.cloudflare!.getDNS(zoneId: zoneId) {
            self.dnsData = rawDNS
        }
    }
    
//    public func getDNSData(byIndex index: Int) -> [DNS] {
    public func getDNSData() -> [DNS] {
        var dnsRecords: [DNS] = []
        
        //  Converting retrieved requests into to an array of requests
        for dnsRecord in dnsData {
            if let name = dnsRecord["name"] as? String,
                let type = dnsRecord["type"] as? String,
                let content = dnsRecord["content"] as? String
            {
                let dns: DNS = DNS(
                    name: name,
                    type: type,
                    content: content)
                dnsRecords.append(dns)
            }
        }
        
        return dnsRecords
    }
}

struct DNS {
    let name: String
    let type: String
    let content: String
}
