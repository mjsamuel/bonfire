//
//  RequestsViewModel.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation
import CoreData

struct RequestsViewModel {
    private let bonfire: Bonfire = Bonfire.sharedInstance
    private var requestsData: [[String: Any]] = []
    private var requests: [Request] = []

    
    /**
     Pulls data from the Cloudflare API
     */
    public mutating func updateData(_ data:[[String:Any]]) {
        self.requestsData = data
    }
    
//    public func getRequests() -> [Request] {
//        // Retrieve the requests objects.
//        // the below method updates the requests array.
//        getRequests()
//
//        // Once the requests array has been updated, return.
//        return requests
//    }


    public mutating func getRequests() -> [Request]{
        
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Requests")
            
            let results = try managedContext.fetch(fetchRequest)
            let requestsArray = results as! [Requests]
            // create temp array
            var tempRequests: [Request] = []
            print("AAAAAAA")
            for req in requestsArray{
                print("a")
                let request: Request = Request(
                    action: req.action!,
                    origin: req.ipAddress!,
                    countryCode: req.countryCode!,
                    time: req.time!)
               
                tempRequests.append(request)
                
            }
            requests = tempRequests
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
        return requests
    }
    
    
    
    // Gets all requests withe the same IP, and updates the object in coredata.
    public func getReqestByIPAddress(reqIPAddress:String) -> Requests?{
        
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Requests")
            fetchRequest.predicate = NSPredicate(format: "ipAddress == %@", reqIPAddress)
            
            let results = try managedContext.fetch(fetchRequest)
            let requests = results as! [Requests]
            
            // Iterate through all records with the provided IP, and update them with the new passed in action.
            return requests[0]
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
        return nil
    }
}



/**
 Helper struct to store and pass around requests
 
 - Parameters
 - action: The name of the country
 - origin: IP address of where the request came from
 - countryCode: The country that the request originated from
 - time: Time that the request was made
 */
struct Request {
    let action: String
    let origin: String
    let countryCode: String
    let time: String
}
