//
//  AnalyticsViewModel.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

struct AnalyticsViewModel {
    private let bonfire: Bonfire = Bonfire.sharedInstance
    
    private var pageviews: Int = 0
    private var threats: Int = 0
    private var cached: Int = 0
    private var uncached: Int = 0
    private var percentCached: Float = 0
    private var countries: [String: Int] = [:]
    private var costPerMonth: Float = 0
    private var costPerRequest: Float = 0
    
    init() {
        updateData()
    }
    
    public mutating func updateData() {
        if let rawData = bonfire.cloudflare!.getAnalytics(zoneId: "test") {
            self.pageviews = rawData["pageviews"] as! Int
            self.threats = rawData["threats"] as! Int
            self.cached = rawData["requests_cached"] as! Int
            self.uncached = rawData["requests_uncached"] as! Int
            
            self.countries = rawData["top_countries"] as! [String: Int]
            
            let allRequests: Int = self.cached + self.uncached
            self.percentCached = Float(self.cached) / Float(allRequests) * 100
        }
    }
    
    public func getPageviews() -> String {
        return String(self.pageviews)
    }
    
    public func getThreats() -> String {
        return String(self.threats)
    }
    
    public func getCached() -> String {
        return String(self.cached)
    }
    
    public func getUncached() -> String {
        return String(self.uncached)
    }
    
    public func getPercentCached() -> String {
        return String(percentCached)
    }
    
    public func getCountries() -> [String: Int] {
        return countries
    }
    
    public func getCostPerMonth() -> String {
        return String(costPerMonth)
    }
    
    public func getCostPerRequest() -> String {
        return String(costPerRequest)
    }
}
