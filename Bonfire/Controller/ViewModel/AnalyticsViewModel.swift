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
    
    init() {
//        updateData()
    }
    
    /**
     Pulls data from the Cloudflare API
     */
    public mutating func updateData(_ data:[String:Any]) {
        self.pageviews = data["pageviews"] as! Int
        self.threats = data["threats"] as! Int
        self.cached = data["requests_cached"] as! Int
        self.uncached = data["requests_uncached"] as! Int
        self.countries = data["top_countries"] as! [String: Int]
    }
    
    public mutating func updatePriceData(_ price:Float) {
        self.costPerMonth = price
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
        for(countryCode, noRequests) in countries {
            let name: String = self.getCountry(countryCode: countryCode)
            countriesArray.append(Country(name: name, noRequests: noRequests))
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
        let allRequests: Int = self.cached + self.uncached
        let costPerRequest: Float = self.costPerMonth / Float(allRequests)
        
        return String(costPerRequest)
    }
    
    /**
     Converts several ISO 3166 country codes to their country name
     
     - Parameters:
        - countryCode: A valid ISO 3166 country code
     - Returns: The country name if successful or the passed in code if unsuccessful
     */
    private func getCountry(countryCode: String) -> String {
        let countryName: String
        
        switch countryCode {
            case "AU":
                countryName = "Australia"
            case "US":
                countryName = "United States"
            case "GB":
                countryName = "Great Britain"
            case "CN":
                countryName = "China"
            case "RU":
                countryName = "Russia"
            case "JP":
                countryName = "Japan"
            case "DE":
                countryName = "Germany"
            case "FR":
                countryName = "France"
            case "IT":
                countryName = "Italy"
            case "IN":
                countryName = "India"
            case "ZA":
                countryName = "South Africa"
            default:
                countryName = countryCode
        }
        
        return countryName
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
