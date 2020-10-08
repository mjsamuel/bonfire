//
//  Cloudflare.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//
import Foundation
import Alamofire

struct Cloudflare {
    
    private let cfBaseURL = "https://api.cloudflare.com/client/v4/"
    public var isLoggedIn = false
    private var apiKey = ""
    private var apiEmail = ""
    init(email: String, apiKey: String) {
        self.apiKey = apiKey
        self.apiEmail = email
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
    
    public func makeRequest(endpoint: String, method: HTTPMethod, showActInd: Bool, completion: @escaping (_ response: Dictionary<String, Any>)->()) {
        self.makeRequest(endpoint: endpoint, method: method, data: nil, showActInd: showActInd, completion: completion)
    }
    
    /**
     Calls Clourflares's get zones API endpoint and returns a list of all zones
     API documentation:
     [GET zones](https://api.cloudflare.com/#zone-list-zones)
     
     - Returns: A dictionary containing relevant data points
     */
    public func getZones(completion: @escaping (_ zones: [Zone])->()) {
        var retVal: [Zone] = []
        self.makeRequest(endpoint: "zones", method: .get, showActInd: true, completion: { response in
            if let result: Array<Dictionary<String, Any>> = response["result"] as? Array<Dictionary<String, Any>> {
                for zone in result {
                    if let zname:String = zone["name"] as? String, let zid:String = zone["id"] as? String {
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

     - Returns: A dictionary containing relevant data points
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
    
    /**
     Calls Clourflare's billing API endpoint and retrieves their subscription costs
     
     API documentation:
     [GET user/subscriptions](https://api.cloudflare.com/#user-subscription-properties)
     
     - Returns: The cost per month of the user's subscription
     */
    public func getCosts(completion: @escaping (_ data: [String: Any]?)->()) {
        self.makeRequest(endpoint: "user/subscriptions", method: .get, showActInd: false, completion: { response in
            if let resultsArray = response["result"] as? [Any] {
                if resultsArray.count > 0 {
                    if let results = resultsArray[0] as? [String: Any],
                        let price = results["price"] as? Float {
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
     - Returns: The cost per month of the user's subscription
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
            if let dataArray = response["data"] as? [String: Any],
                let viewer = dataArray["viewer"] as? [String: Any],
                let zones = viewer["zones"] as? [Any],
                let zone = zones[0] as? [String: Any],
                let requests = zone["firewallEventsAdaptive"] as? [[String: Any]] {
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
     
     - Returns: A list of all current DNS records
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
     
     - Returns: Returns true if successful and false if not
     */
    public func updateDNS() -> Bool {
        // var hardcoded to true for testing
        let success: Bool = true
        
        // pass data to API
        // if pass is successful
        // set success to true and return
        // else set success to false and return
        return success
    }
    
    /**
     Sends new DNS data to Cloudflare API
     
     - Returns: Returns true if successful and false if not
     */
    public func newDNS () -> Bool {
        // var hardcoded to true for testing
        let success: Bool = true
        
        // pass data to API
        // if pass is successful
        // set success to true and return
        // else set success to false and return
        return success
    }
}
