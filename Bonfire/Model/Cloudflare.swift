//
//  Cloudflare.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//
import Foundation
import Alamofire
import CoreData

struct Cloudflare {
    
    private var cfBaseURL = "https://api.cloudflare.com/client/v4/"
    public var isLoggedIn = false
    private var apiKey = ""
    private var apiEmail = ""
    
    
    init(email: String, apiKey: String) {
        // Check if there us a valid 'session' (coredata has a record of a login)
        // NOTE:
        //      CoreData will only ever have ONE record in the Account table.
        //      If a record exists, then a user has saved a 'session' thus us logged in.
        //      A 'session' will save the users login containing:
        //             - Their email address.
        //             - Their API key.
        //             - The selected Zone (selected at login or updated in settings)
        
        // Check if an account is already stored
        let account:Account? = self.getRegistedAccountDetails()
        if account != nil{
            self.apiKey = account!.apiKey ?? apiKey
            self.apiEmail = account!.email ?? email
        }else{
            self.apiKey = apiKey
            self.apiEmail = email
        }
        // If in a testing enviroment the cfBaseURL is set to locaclhost in order to access our mock server
        if ProcessInfo.processInfo.arguments.contains("USE_MOCK_SERVER") {
            self.cfBaseURL = "http://localhost:8080/"
        }
       


        
    }
    

    
    /**
     Make An API Request
     This method makes a request to the Cloudflare REST API.
     Parameters:
     - endpoint: The desired API endpoint (e.g. zones)
     - method: The HTTP method to use, generally .get or .post
     - showActInd: Boolean of if a spinner should be shown
     - completion: The code block to run once a response has been recieved (Recieves the parameter "response" as a Dictionary)
    **/
    public func makeRequest(endpoint: String, method: HTTPMethod, data: Parameters?, showActInd: Bool, completion: @escaping (_ response: Dictionary<String, Any>)->()) {
        // Show Activity Indicator
        let appDel = UIApplication.shared.delegate as! AppDelegate
        if showActInd {
            appDel.toggleActInd(on: true)
        }
        print("+++++")
        print(self.apiKey)
        print(self.apiEmail)
        print(cfBaseURL)
        print("endpoint")
        print(endpoint)
        let headers = [
            "X-Auth-Key": self.apiKey,
            "X-Auth-Email": self.apiEmail,
            "Content-Type": "application/json"]
        Alamofire.request(URL(string: cfBaseURL + endpoint)!, method: method, parameters: data,encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            appDel.toggleActInd(on: false)
            switch response.result {
            case .success(_):
                if let resultDict = response.result.value as? Dictionary<String, Any> {

                    completion(resultDict)
                } else {
                    completion(["BF_Error":"Unknown"])
                }
            case .failure(_):
                completion(["BF_Error":"Unknown"])
            }
        }
    }
    
    /**
     Overloaded version of above to remove the data parameter for calls that do not need it.
    **/
    public func makeRequest(endpoint: String, method: HTTPMethod, showActInd: Bool, completion: @escaping (_ response: Dictionary<String, Any>)->()) {
        self.makeRequest(endpoint: endpoint, method: method, data: nil, showActInd: showActInd, completion: completion)
    }
    
    
    /**
     Calls Clourflares's get zones API endpoint and returns a list of all zones
     API documentation:
     [GET zones](https://api.cloudflare.com/#zone-list-zones)
     
     Parameters:
     - completion: The code block to run once a response has been recieved (Recieves the parameter "zones" as an Array)
     */
    public func getZones(completion: @escaping (_ zones: [Zone])->()) {
        var retVal: [Zone] = []
        self.makeRequest(endpoint: "zones", method: .get, showActInd: true, completion: { response in
            if let result: Array<Dictionary<String, Any>> = response["result"] as? Array<Dictionary<String, Any>> {
                for zone in result {
//                    print("\(zone["name"])")
                    if let zname:String = zone["name"] as? String, let zid:String = zone["id"] as? String {
                        print("got name")
                        retVal.append(Zone(name: zname, id: zid))
                    }
                }
            }
            completion(retVal)
        })
    }
    
    /**
     Calls Clourflare's analytics API endpoint and returns certain data points
     
     API documentation:
     [GET zones/:zone_identifier/analytics/dashboard](https://api.cloudflare.com/#zone-analytics-dashboard)
     
     - Parameters:
     - zoneId: The id of the zone that you want analytics for
     - completion: The code block to run once a response has been recieved (Recieves the parameter "data" as a Dictionary)
     */
    public func getAnalytics(zoneId: String, completion: @escaping (_ data: [String: Any]?)->()) {
        self.makeRequest(endpoint: "zones/"+zoneId+"/analytics/dashboard", method: .get, showActInd: false, completion: { response in
            if let results = response["result"] as? [String: Any],
                let totals = results["totals"] as? [String: Any],
                let requests = totals["requests"] as? [String: Any],
                let requests_cached = requests["cached"] as? Int,
                let requests_uncached = requests["uncached"] as? Int,
                let top_countries = requests["country"] as? [String: Int],
                let threats = totals["threats"] as? [String: Any],
                let threats_all = threats["all"] as? Int,
                let pageviews = totals["pageviews"] as? [String: Any],
                let pageviews_all = pageviews["all"] as? Int {
                // Add records for the requests per country associated to this zone.
                for country in top_countries{
                    // Add the country name (code) and the number of requests its made, identified by the zoneID.
                    
                    self.addCountryRecord(countryName: country.key, requestCount: country.value, zoneID: zoneId)
                }
                
                // Add record of analytics
                self.creatAnalytics(numRequestsPerMonth: pageviews_all, numRequestsCached: requests_cached, numRequestsUncached: requests_uncached, numThreatsPerMonth: threats_all)
                
                completion([
                    "requests_cached": requests_cached,
                    "requests_uncached": requests_uncached,
                    "top_countries": top_countries,
                    "threats": threats_all,
                    "pageviews": pageviews_all
                    ])
            } else {
                    completion(nil)
            }
        })
        
    }
    
    
    // Creat the analytics
    
    /**
     Calls Clourflare's billing API endpoint and retrieves their subscription costs
     
     API documentation:
     [GET user/subscriptions](https://api.cloudflare.com/#user-subscription-properties)
     
     - Parameters:
     - completion: The code block to run once a response has been recieved (Recieves the parameter "data" as a Dictionary)
     */
    public func getCosts(completion: @escaping (_ data: [String: Any]?)->()) {
        self.makeRequest(endpoint: "user/subscriptions", method: .get, showActInd: false, completion: { response in
            if let resultsArray = response["result"] as? [Any] {
                if resultsArray.count > 0 {
                    if let results = resultsArray[0] as? [String: Any],
                        let price = results["price"] as? Float {
                        
                        // Update the CoreData with the costs per month (flat cost)
                        self.updateAnalyticsWithCost(cost:price)
                        
                        completion([
                            "price": price
                            ])
                    } else {
                        completion(nil)
                    }
                }
            }
        })
    }
    
    /**
     Calls Clourflare's GraphQL API to retrieve a list of incoming requests
     
     API documentation:
     [GraphQL](https://developers.cloudflare.com/analytics/graphql-api/tutorials/querying-firewall-events)
     
     - Parameters:
     - zoneId: The id of the zone that you want the list of requests for
     - completion: The code block to run once a response has been recieved (Recieves the parameter "data" as an Array wrapped Dictionary)
     */
    public func getRequests(zoneId: String, completion: @escaping (_ data:[[String: Any]]?)->()) {
        let date = Calendar.current.date(byAdding: .second, value: 400, to: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        
        let graphQLData = [
                "query": "query ListFirewallEvents($zoneTag: string, $filter: FirewallEventsAdaptiveFilter_InputObject) {viewer {zones(filter: { zoneTag: $zoneTag }) {firewallEventsAdaptive(filter: $filter limit: 10 orderBy: [datetime_DESC]) {action clientAsn clientCountryName clientIP clientRequestPath clientRequestQuery datetime source userAgent}}}}",
                "variables": [
                    "zoneTag": zoneId,
                    "filter": [
                        "datetime_geq": formatter.string(from: date!)
                    ]
                ]
            ] as Parameters
        print(graphQLData)
        self.makeRequest(endpoint: "graphql", method: .post, data: graphQLData, showActInd: false, completion: { response in
            
            // Date formatter fot converting from ISO 8601 to a date object
            let isoFormatter = ISO8601DateFormatter()
            // Date formatter to convert the date object to a string in local time
            let stringFormatter = DateFormatter()
            stringFormatter.dateFormat = "hh:mm:ss"
            
//            print(response)

            if let dataArray = response["data"] as? [String: Any],
                let viewer = dataArray["viewer"] as? [String: Any],
                let zones = viewer["zones"] as? [Any],
                let zone = zones[0] as? [String: Any],
                let requests = zone["firewallEventsAdaptive"] as? [[String: Any]] {
                
                // Extract the data needed to add the request record, add it to coredata.
                for requestData in requests {
                    if let action = requestData["action"] as? String,
                        let ip = requestData["clientIP"] as? String,
                        let countryCode = requestData["clientCountryName"] as? String,
                        let datetime = requestData["datetime"] as? String
                    {
                        // Converting ISO 8601 string to a string in local time
                        let date = isoFormatter.date(from:datetime)!
                        self.creatRequestRecord(reqAction: action, reqIPAddress: ip, reqCountryCode: countryCode, reqTime: stringFormatter.string(from: date))
                        
                    }
                }
                
                completion(requests)
            } else {
                completion(nil)
            }
        })
    }
    
    /**
     Calls Clourflare's DNS API endpoint and retrieves the zones DNS records
     
     API documentation:
     [GET zones/:zone_identifier/dns_records](https://api.cloudflare.com/#dns-records-for-a-zone-list-dns-records)
     
     - Parameters:
     - zoneId: The id of the zone that you want the list of requests for
     - completion: The code block to run once a response has been recieved (Recieves the parameter "data" as an Array wrapped Dictionary)
     */
    public func getDNS(zoneId: String, completion: @escaping (_ data:[[String: Any]]?)->()) {
        self.makeRequest(endpoint: "zones/"+zoneId+"/dns_records", method: .get, showActInd: false, completion: { response in
            if let results = response["result"] as? [[String: Any]] {
                completion(results)
                
            } else {
                completion(nil)
            }
        })
    }
    
    /**
     Updates an existing DNS listing by making a request to Cloudflares API
     
     API documentation:
     [PUT zones/:zone_identifier/dns_records/:identifier](https://api.cloudflare.com/#dns-records-for-a-zone-update-dns-record)
     
     - Parameters:
     - dnsRecord: A DNS object with the new data
     - completion: The code block to run once a response has been recieved (Recieves the parameter "success" as a Bool)
     */
    public func updateDNS(dnsRecord: DNS, completion: @escaping (_ success:Bool)->()) {
        let endpoint = "zones/"+dnsRecord.zoneID+"/dns_records/"+dnsRecord.id!
        let data = [
            "type": dnsRecord.type,
            "name": dnsRecord.name,
            "content": dnsRecord.content,
            "ttl": dnsRecord.ttl
        ] as Parameters
        self.makeRequest(endpoint: endpoint, method: .put, data: data, showActInd: true, completion: { response in
            if let _ = response["BF_Error"] {
                completion(false)
            } else {
                
                self.updateDNSRecordByID(recordID: dnsRecord.id!, updatedIPAddress: dnsRecord.content, recordName: dnsRecord.type, recordTTL: dnsRecord.ttl, recordType: dnsRecord.type)
            
                
                completion(true)
                
            }
        })
    }
    
    /**
     Sends new DNS data to Cloudflare API
     
     API documentation:
     [POST zones/:zone_identifier/dns_records](https://api.cloudflare.com/#dns-records-for-a-zone-create-dns-record)
     
     - Parameters:
     - dnsRecord: A DNS object with the new data
     - completion: The code block to run once a response has been recieved (Recieves the parameter "success" as a Bool and "newRecord" as a DNS object of the new data)
     */
    public func newDNS (newRecord: DNS, completion: @escaping (_ success:Bool, _ newRecord:DNS?)->()) {
        let endpoint = "zones/"+newRecord.zoneID+"/dns_records/"
        print("RECORD TYPE")
        let data = [
            "type": newRecord.type,
            "name": newRecord.name,
            "content": newRecord.content,
            "ttl": newRecord.ttl
        ] as Parameters
        print(data)

        self.makeRequest(endpoint: endpoint, method: .post, data: data, showActInd: true, completion: { response in
            print("+++++++")
            print(response)
            if let result = response["result"] as? [String: Any],
                let id = result["id"] as? String,
                let name = result["name"] as? String,
                let content = result["content"] as? String,
                let ttl = result["ttl"] as? Int,
                let type = result["type"] as? String,
                let zone_id = result["zone_id"] as? String {
                let createdDNS = DNS(name: name, type: type, content: content, id: id, ttl: ttl, zoneID: zone_id)
//                self.createNewDNSRecord(recordID: id, updatedIPAddress: content, recordName: name, recordTTL: ttl, recordType: type)
                completion(true, createdDNS)
            } else {
                completion(false, nil)
            }
        })
    }
    
    
    
    
    
    private func addCountryRecord(countryName:String, requestCount:Int, zoneID: String){
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        let countryAnalyticsObj = NSEntityDescription.entity(forEntityName: "CountryAnalytics" , in: managedContext)!
        let countryAnalytics = NSManagedObject(entity: countryAnalyticsObj, insertInto: managedContext) as! CountryAnalytics
        
        countryAnalytics.countryName = countryName
        countryAnalytics.numRequests = Int64(requestCount)
        countryAnalytics.zoneID = zoneID
        print("adding country")
        appDelegate.saveContext()
    }
    
    private func creatAnalytics(numRequestsPerMonth:Int, numRequestsCached:Int, numRequestsUncached:Int, numThreatsPerMonth:Int){
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        let analyticsObj = NSEntityDescription.entity(forEntityName: "Analytics" , in: managedContext)!
        let analytics = NSManagedObject(entity: analyticsObj, insertInto: managedContext) as! Analytics
        
        analytics.numRequestsPerMonth = Int64(numRequestsPerMonth)
        analytics.numRequestsCached = Int64(numRequestsCached)
        analytics.numRequestsUncached = Int64(numRequestsUncached)
        
        analytics.numThreatsPerMonth = Int64(numThreatsPerMonth)
        // Get the cost if using workers $5.00 per 10,000,000 requests
        let costPerReq:Float = 5.00 / 10000000
        
        analytics.costPerRequest = costPerReq * 10000000
        
        
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
    
    private func updateAnalyticsWithCost(cost: Float32){
        
        
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Analytics")

            let results = try managedContext.fetch(fetchRequest)
            let analytics = results as! [Analytics]
            if analytics.count > 0{
                analytics[0].flatCostPerMonth = cost
            }
            appDelegate.saveContext()

            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
    }
    
    
    
    private func creatRequestRecord(reqAction:String, reqIPAddress:String, reqCountryCode:String, reqTime:String){
        // Check if record already exists, if so, dont add to CoreData
        print("CHECKING REQUESTS")
        print(checkIfRecordExists(reqIPAddress: reqIPAddress, reqCountry: reqCountryCode, reqTime: reqTime))
        if checkIfRecordExists(reqIPAddress: reqIPAddress, reqCountry: reqCountryCode, reqTime: reqTime) == true{
            // Get a reference to your App Delegate
            let appDelegate = AppDelegate.shared
            // Hold a reference to the managed context
            let managedContext = appDelegate.persistentContainer.viewContext
            let requestObj = NSEntityDescription.entity(forEntityName: "Requests" , in: managedContext)!
            let request = NSManagedObject(entity: requestObj, insertInto: managedContext) as! Requests
            request.action = reqAction
            request.ipAddress = reqIPAddress
            request.countryCode = reqCountryCode
            request.time = reqTime
            
            
            appDelegate.saveContext()
        }
    }
    
    private func checkIfRecordExists(reqIPAddress:String, reqCountry:String, reqTime:String) -> Bool{
        
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Requests")
            fetchRequest.predicate = NSPredicate(format: "ipAddress == %@", reqIPAddress)
            fetchRequest.predicate = NSPredicate(format: "countryCode == %@", reqCountry)
            fetchRequest.predicate = NSPredicate(format: "time == %@", reqTime)
            let results = try managedContext.fetch(fetchRequest)
            let requests = results as! [Requests]
            // Check if the record already exists. more then 0 = false
            print("valusssss")
            print(requests.count)
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
    
    
    
    // Update the CoreData copy of the DNS record
    private func updateDNSRecordByID(recordID:String, updatedIPAddress:String, recordName:String, recordTTL:Int, recordType:String){
        
        // Get a reference to your App Delegate
        let appDelegate = AppDelegate.shared
        
        // Hold a reference to the managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ClfDNS")
            fetchRequest.predicate = NSPredicate(format: "recordID == %@", updatedIPAddress)
            
            let results = try managedContext.fetch(fetchRequest)
            let dnsRecords = results as! [ClfDNS]
            
            // Iterate through all records with the provided ID, and update them with the new passed in IP.
            for record in dnsRecords{
                
                record.ipAddress = updatedIPAddress
                record.name = recordName
                record.ttl = Int16(recordTTL)
                record.recordType = recordType
                
            }
            
            
            appDelegate.saveContext()
            
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
    }
    
    
    // Create a new DNS record for the local CoreData
    private func createNewDNSRecord(recordID:String, updatedIPAddress:String, recordName:String, recordTTL:Int, recordType:String){
        // Check if record already exists, if so, dont add to CoreData
        if self.checkIfDNSRecordExists(dnsRecordID: recordID){
            // Get a reference to your App Delegate
            let appDelegate = AppDelegate.shared
            
            // Hold a reference to the managed context
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let requestObj = NSEntityDescription.entity(forEntityName: "ClfDNS" , in: managedContext)!
            let dnsRecord = NSManagedObject(entity: requestObj, insertInto: managedContext) as! ClfDNS
            
            dnsRecord.recordID = recordID
            dnsRecord.ipAddress = updatedIPAddress
            dnsRecord.name = recordName
            dnsRecord.ttl = Int16(recordTTL)
            dnsRecord.recordType = recordType
            
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
