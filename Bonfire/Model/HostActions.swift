//
//  HostActions.swift
//  Bonfire
//
//  Created by James on 22/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation
import CoreData

enum Action: String {
    case allow = "whitelist" // allows the host to the site.
    case JSchallange = "js_challenge" // wait 5 seconds to determine if the host is a legit user.
    case CAPTCHAchallange = "challenge" // shows the host a CAPTCHA before being allowed to the site
    case ban = "block" // bans the host
    case normal = "allow"
    
    static let allValues = [allow, JSchallange, CAPTCHAchallange, ban, normal]
    
    // Describes what each action will do.
    var description: String {
        switch self {
        // Inorder of impact to the user.
        case .allow:
            return "Ensures that an IP address will never be blocked from accessing your website. The IP may still be mitigated if part of a DDoS attack. Only use for verified IPs that you trust!"
        case .JSchallange:
            return "The JavaScript challenge page requires the visitor to wait 5 seconds while Cloudflare determines if the visitor is coming from a real browser. The challenge requires the visitor's browser to answer a math problem which takes a bit of time to compute. Once successfully answered, the browser will be remembered and won't be challenged again."
        case .CAPTCHAchallange:
            return "Specified IP addresses will be shown a CAPTCHA before being allowed to access your website"
        case .ban:
            return "Ensures that an IP address will never be allowed to access your website"
        case .normal:
            return "Removes any action previously set. The IP can access your site as normal."
        }
    }
    
}


struct HostAction {
    // The action the object is currently classed as. See the Action enum
    private var action: Action

    // The IP address of the object. Also known as the hostIP.
    private var ipAddress: String
    
    // We need to know if this is ipv4 or ipv6 for use in the API request.
    private var isIPV6: Bool
    
    // constructor
    init(action: Action, hostIP: String) {
        self.ipAddress = hostIP
        self.action = action
        self.isIPV6 = hostIP.contains(":")
    }
    
    mutating func setAction(selectedAction: Action, completion: @escaping (_ success:Bool)->()) {
        // Since the action is changing for the object we can also make the API call to Cloudflare. Only call if the action is different to the current state.
        sendActionToCloudflare(selectedAction: selectedAction, hostIP: self.ipAddress, completion: completion)

    }
    
    // Send API calls to Clourflare based on the action
    func sendActionToCloudflare(selectedAction: Action, hostIP:String, completion: @escaping (_ success:Bool)->()) {
        
        let ruleID:String = getRuleIDByIPAddress(reqIPAddress: hostIP) ?? ""
        if (selectedAction == Action.normal) {
            self.sendRemoveRuleRequest(ruleID: ruleID, completion: completion)
        } else {
            if ruleID != ""{
                self.sendRemoveRuleRequest(ruleID: ruleID, completion: completion)
            }
            self.sendAddRuleRequest(hostIP: hostIP, action: selectedAction, completion: completion)
        }
        
        // Update the rule with the new action
        self.updateRequest(reqIPAddress: hostIP, newActon: selectedAction.rawValue)
    }
    
    func getAction() -> Action {
        return self.action
    }
    
    func getIpAddress() -> String {
        return self.ipAddress
    }
    
    private func sendRemoveRuleRequest(ruleID:String, completion: @escaping (_ success:Bool)->()) {
        let bonfire = Bonfire.sharedInstance
        let currentZone = bonfire.currentZone
        let endpoint = "zones/"+(currentZone?.getId())!+"/firewall/access_rules/rules/"+ruleID
        bonfire.cloudflare?.makeRequest(endpoint: endpoint, method: .delete, showActInd: true, completion: { response in

            if let _ = response["BF_Error"] {
                bonfire.showErrorAlert(title: "Error", message: "An unknown error occured when attempting to remove firewall rule.")
                completion(false)
            } else {
                completion(true)
            }
        })
    }
    
    private func sendAddRuleRequest(hostIP:String, action:Action, completion: @escaping (_ success:Bool)->()) {
        let bonfire = Bonfire.sharedInstance
        let currentZone = bonfire.currentZone
        

        let endpoint = "zones/"+(currentZone?.getId())!+"/firewall/access_rules/rules"
        let params = [
            "mode": action.rawValue,
            "configuration": [
                "target": self.isIPV6 ? "ip6" : "ip",
                "value": hostIP
            ],
            "notes": "Created in Bonfire"
        ] as [String : Any]

        bonfire.cloudflare?.makeRequest(endpoint: endpoint, method: .post, data: params, showActInd: true, completion: { response in
            // only do if making request to create actions against an IP
            if let result = response["result"] as? Dictionary<String, Any>{
                if let ruleID = result["id"]{
                    // Update record with the returned ID
                    self.updateRequestWithID(reqIPAddress: hostIP, ruleID: ruleID as! String)
                }
            }

            if let _ = response["BF_Error"] {
                bonfire.showErrorAlert(title: "Error", message: "An unknown error occured when attempting to add firewall rule.")
                completion(false)
            } else {
                completion(true)
            }
        })
    }
    
    private func updateRequestWithID(reqIPAddress:String, ruleID:String){
        
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
            for req in requests{
                req.requestID = ruleID
            }
            
            
            appDelegate.saveContext()
            
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
    }
    
    // Gets all requests withe the same IP, and updates the object in coredata.
    private func updateRequest(reqIPAddress:String, newActon: String){
        
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
            for req in requests{
                req.action = newActon
            }
            
            
            appDelegate.saveContext()
            
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
    }
    
    
    // Gets all requests withe the same IP, and updates the object in coredata.
    private func getRuleIDByIPAddress(reqIPAddress:String) -> String?{
        
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
            return requests[0].requestID
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
        return ""
    }
    
}
