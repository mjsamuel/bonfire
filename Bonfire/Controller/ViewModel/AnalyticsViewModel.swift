//
//  AnalyticsViewModel.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

struct AnalyticsViewModel {
    private let bonfire: Bonfire = Bonfire.sharedInstance
    
//    private var pageview: Int
//    private var threats: Int
//    private var cached: Int
//    private var uncached: Int
//    private var percentCached: Float
//    private var countries: [String: Int]
//    private var costPerMonth: Float
//    private var costPerRequest: Float
    
    init() {
//        let rawData = bonfire.cloudflare!.getAnalytics(zoneId: "test") as! [String: [String: [String: Any]]]
//        let requestData = rawData["result"]?["totals"]?["requests"]
//        let countryData = requestData["country"] as! [String: Int]
    }
    
    public mutating func retrieveAnalytics() {
        
    }
}
