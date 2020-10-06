//
//  Bonfire.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class Bonfire {

    static let sharedInstance = Bonfire()
    
    public var cloudflare: Cloudflare?
    public var zones: [Zone]?
    public var currentZone: Zone?

    private init() {
        cloudflare = Cloudflare(email: "...", apiKey: "...")
        cloudflare?.getZones(completion: { zones in
            if zones.count > 0 {
                self.currentZone = zones[0]
            }
        })
        
    }
    
    /**
     Logs in a user with thier credentials
     
     - Parameters:
        - email: The email of the user
        - apiKey: The api key corresponding to that account
     */
    public func login(email: String, apiKey: String, completion: @escaping (_ success: Bool)->()) {
        cloudflare = Cloudflare(email: email, apiKey: apiKey)
        cloudflare?.getZones(completion: { zones in
            self.cloudflare!.isLoggedIn = (zones.count > 0)
            
            // Iterate through all the zones asscosiated to the account, and register them all with CoreData
            for zone in zones {
                self.registerZones(zoneName: zone.name, zoneID: zone.getId())
            }
            

            
            if self.cloudflare!.isLoggedIn {
                self.currentZone = zones[0]
                self.zones = zones
            } else {
                // Show error alert no zones found or not valid creds
                self.showErrorAlert(title: "Login Failed", message: "Please confirm your email and API key. You must have atleast 1 zone configured in CloudFlare.")
            }
            completion(self.cloudflare!.isLoggedIn)
        })
        
        
        
    
        
        
    }
    
    public func registerZones(zoneName: String, zoneID: String){
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        let clfZone = NSEntityDescription.entity(forEntityName: "ClfZone" , in: managedContext)!
        let clfZoneObj = NSManagedObject(entity: clfZone, insertInto: managedContext) as! ClfZone
        
        clfZoneObj.name = zoneName  // The name or "domain name"
        clfZoneObj.zoneID = zoneID  // The internal ID Cloudflare uses to identify the domain.
        
        appDelegate.saveContext()

    }
    
    public func getZones() -> [ClfZone]? {
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ClfZone")
            
            let results = try managedContext.fetch(fetchRequest)
            return results as? [ClfZone]
            
        }
        catch let error as NSError {
            print("Could not fetch \(error) , \(error.userInfo )")
            return nil
        }

    }
    
    
    private func registerAccountDetails(accEmail: String, accZoneID:String, accAPIKey:String) {
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        let account = NSEntityDescription.entity(forEntityName: "Account" , in: managedContext)!
        
        // Insert into the Managed Context
        let accountObj = NSManagedObject(entity: account, insertInto: managedContext) as! Account
        
        accountObj.email = accEmail     // The email account of the user.
        accountObj.zoneID = accZoneID   // The zone the user wants to use with the app
        accountObj.apiKey = accAPIKey   // The API key for the account. This will be used to make API calls later.
    
        // Save object
        appDelegate.saveContext()
        
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
            return account[0]

        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
        return nil
    }
    
    
    /**
     Logs out a user and discards their credentials
     */
    public func logout() {
        cloudflare = nil
        zones = nil
        currentZone = nil
    }
    
    /**
     Shows an alert view ontop of any view controller by creating a new window and presenting inside that window.
    **/
    public func showErrorAlert(title:String, message:String, buttonTitle:String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        let alertWindow = UIWindow()
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController = UIViewController()
        alertWindow.backgroundColor = .clear
        alertWindow.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
}
