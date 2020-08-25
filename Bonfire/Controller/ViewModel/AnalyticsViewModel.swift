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
    private var countries: [String: Int] = [:]
    private var costPerMonth: Float = 0
    private var costPerRequest: Float = 0
    
    init() {
        updateData()
    }
    
    /**
     Pulls data from the Cloudflare API
     */
    public mutating func updateData() {
        if let rawData = bonfire.cloudflare!.getAnalytics(zoneId: "test") {
            self.pageviews = rawData["pageviews"] as! Int
            self.threats = rawData["threats"] as! Int
            self.cached = rawData["requests_cached"] as! Int
            self.uncached = rawData["requests_uncached"] as! Int
            self.countries = rawData["top_countries"] as! [String: Int]
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
        let allRequests: Int = self.cached + self.uncached
        let percentCached: Float = Float(self.cached) / Float(allRequests) * 100
        
        return String(percentCached)
    }
    
    /**
     - Returns: A sorted array of countries from largest number of requests, to smallest
     */
    public func getCountries() -> [Country] {
        var countriesArray: [Country] = []
        
        //  Converting retrieved countries to an array of countries
        for(country, noRequests) in countries {
            countriesArray.append(Country(name: country, noRequests: noRequests))
        }
        
        // Sorting the array from largest to smallest number of requests
        countriesArray.sort {
            $0.noRequests > $1.noRequests
        }
        
        return countriesArray
    }
    
    public func getCostPerMonth() -> String {
        return String(costPerMonth)
    }
    
    public func getCostPerRequest() -> String {
        return String(costPerRequest)
    }
}

/**
 Helper struct to store and pass around country information
 
 - Parameters
    - name: The name of the country
    - noRequests: The number of requests for that country
 */
struct Country {
    let name: String
    let noRequests: Int
}
