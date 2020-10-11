//
//  DNSViewModel.swift
//  Bonfire
//
//  Created by Dylan Sbogar on 29/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation
import CoreData

struct DNSViewModel {
    private let bonfire: Bonfire = Bonfire.sharedInstance
    private var dnsData: [[String: Any]] = []
    
    /**
     Pulls data from the Cloudflare API
     */
    public mutating func updateData(_ data:[[String: Any]]) {
        
//        self.dnsData = data
        for dnsRecord in data {
            if let name = dnsRecord["name"] as? String,
                let type = dnsRecord["type"] as? String,
                let content = dnsRecord["content"] as? String,
                let id = dnsRecord["id"] as? String,
                let ttl = dnsRecord["ttl"] as? Int
            {
                // Generate records in coreData for DNS records
                self.createDNSRecord(recordIPAddress: content, recordName: name, recordType: type, recordTTL: ttl, recordID: id)
            }
        }
    }
    
    public func getDNSData() -> [DNS] {
        var dnsRecords: [DNS] = []
        
        //  Converting retrieved requests into to an array of requests
//        for dnsRecord in dnsData {
//            if let name = dnsRecord["name"] as? String,
//                let type = dnsRecord["type"] as? String,
//                let content = dnsRecord["content"] as? String,
//                let id = dnsRecord["id"] as? String,
//                let ttl = dnsRecord["ttl"] as? Int
//            {
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ClfDNS")
            
            let results = try managedContext.fetch(fetchRequest)
            let dnsRecordArray = results as! [ClfDNS]

            for record in dnsRecordArray{
                
                let dns: DNS = DNS(
                    name: record.name!,
                    type: record.recordType!,
                    content: record.ipAddress!,
                    id: record.recordID!,
                    ttl: Int(record.ttl),
                    zoneID: bonfire.currentZone!.getId())
                print("hello")
                dnsRecords.append(dns)
            }
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
        
        return dnsRecords
    }

    
    
    // Create new DNS Records.
    private func createDNSRecord(recordIPAddress:String, recordName:String, recordType:String, recordTTL:Int, recordID:String){
        if self.checkIfDNSRecordExists(dnsRecordID: recordID){
            // Get a reference to your App Delegate
            let appDelegate = AppDelegate.shared
            
            // Hold a reference to the managed context
            let managedContext = appDelegate.persistentContainer.viewContext
            let dnsObj = NSEntityDescription.entity(forEntityName: "ClfDNS" , in: managedContext)!
            let record = NSManagedObject(entity: dnsObj, insertInto: managedContext) as! ClfDNS
            print("GENERATING DNS RECOD")
            print(recordName)
            record.ipAddress = recordIPAddress
            record.name = recordName
            record.recordType = recordType
            record.ttl = Int16(recordTTL)
            record.recordID = recordID
            
            appDelegate.saveContext()
        }
    }
    
    private func checkIfDNSRecordExists(dnsRecordID:String) -> Bool{
        
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ClfDNS")
            fetchRequest.predicate = NSPredicate(format: "recordID == %@", dnsRecordID)
            
            
            let results = try managedContext.fetch(fetchRequest)
            let requests = results as! [ClfDNS]
            // Check if the record already exists. more then 0 = false
            print("YES WE HAVE GO IN HERE")
            if requests.count <= 0{
                return true
            }else{
                return false
            }
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
        return false
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
