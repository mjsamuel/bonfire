//
//  AnalyticsViewModel.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation
import CoreData

struct AnalyticsViewModel {
    private let bonfire: Bonfire = Bonfire.sharedInstance
    
    private var pageviews: Int = 0
    private var threats: Int = 0
    private var cached: Int = 0
    private var uncached: Int = 0
    private var countries: [String: Int] = [:]
    private var costPerMonth: Float = 0
    private var costPerRequest: Float = 0
    
    /**
     Pulls data from the Cloudflare API
     */
    public mutating func updateData(_ data:[String:Any]) {
        let analytics:Analytics = getAnalytics()!

        
        self.pageviews = Int(analytics.numRequestsPerMonth)
        self.threats = Int(analytics.numThreatsPerMonth)
        self.cached = Int(analytics.numRequestsCached)
        self.uncached = Int(analytics.numRequestsUncached)
//        let counntryAnalytics:[CountryAnalytics] = getCountryAnalytics()
        for country in getCountryAnalytics()!{
            self.countries[String(country.countryName!)] = Int(country.numRequests)
        }
        self.costPerMonth = analytics.flatCostPerMonth
        self.costPerRequest = analytics.costPerRequest


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
            let name: String = self.countryCodeToName(countryCode: countryCode)
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
        let costPerRequest: Float = self.costPerRequest / Float(allRequests)
        return String(costPerRequest)
    }
    
    private func countryCodeToName(countryCode: String) -> String {
        if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
            // Country name was found
            return name
        } else {
            // Country name cannot be found
            return countryCode
        }
    }
    
    private func getAnalytics() -> Analytics? {
        
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Analytics")
            

            let results = try managedContext.fetch(fetchRequest)
            let account = results as! [Analytics]
            return account[0]
//            if account.count > 0{
//                return account[0]
//            }else{
//                return nil
//            }
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
        return nil
    }
    
    public func getRegistedAccountDetails() -> Account? {
        
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Account")
            fetchRequest.fetchLimit = 1
            
            let results = try managedContext.fetch(fetchRequest)
            let account = results as! [Account]
            if account.count > 0{
                return account[0]
            }else{
                return nil
            }
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
        return nil
    }
    
    private func getCountryAnalytics() -> [CountryAnalytics]?{
        
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext

        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"CountryAnalytics")

            let results = try managedContext.fetch(fetchRequest)
            let analytics = results as! [CountryAnalytics]

            return analytics
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
        return nil
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
