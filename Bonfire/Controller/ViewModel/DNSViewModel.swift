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
//        updateData()
    }
    
    /**
     Pulls data from the Cloudflare API
     */
    public mutating func updateData(_ data:[[String: Any]]) {
//        if (bonfire.currentZone != nil) {
//            let zoneId = bonfire.currentZone!.getId()
//            if let rawDNS = bonfire.cloudflare!.getDNS(zoneId: zoneId) {
//                self.dnsData = rawDNS
//            }
//        }
        self.dnsData = data
    }
    
    public func getDNSData() -> [DNS] {
        var dnsRecords: [DNS] = []
        
        //  Converting retrieved requests into to an array of requests
        for dnsRecord in dnsData {
            if let name = dnsRecord["name"] as? String,
                let type = dnsRecord["type"] as? String,
                let content = dnsRecord["content"] as? String,
                let id = dnsRecord["id"] as? String,
                let ttl = dnsRecord["ttl"] as? Int
            {
                let dns: DNS = DNS(
                    name: name,
                    type: type,
                    content: content,
                    id: id,
                    ttl: ttl,
                    zoneID: bonfire.currentZone!.getId())
                dnsRecords.append(dns)
            }
        }
        
        return dnsRecords
    }
}

/**
 Helper struct to store and pass around DNS records
 
 - Parameters
 - name: The name of the request
 - type: The type of request
 - content: The content of the request
 */
public struct DNS {
    var name: String
    var type: String
    var content: String
    var id: String?
    var ttl: Int
    var zoneID: String
}
