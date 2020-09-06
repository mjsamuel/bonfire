//
//  RequestsViewModel.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

struct RequestsViewModel {
    private let bonfire: Bonfire = Bonfire.sharedInstance
    private var requestsData: [[String: Any]] = []

    init() {
        updateData()
    }
    
    /**
     Pulls data from the Cloudflare API
     */
    public mutating func updateData() {
        let zoneId = bonfire.currentZone!.getId()
        if let rawRequests = bonfire.cloudflare!.getRequests(zoneId: zoneId) {
            self.requestsData = rawRequests
        }
    }
    
    public func getRequests() -> [Request] {
        var requests: [Request] = []
        
        // Date formatter fot converting from ISO 8601 to a date object
        let isoFormatter = ISO8601DateFormatter()
        // Date formatter to convert the date object to a string in local time
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "hh:mm:ss"
        
        //  Converting retrieved requests into to an array of requests
        for requestData in requestsData {
            if let action = requestData["action"] as? String,
                let ip = requestData["clientIP"] as? String,
                let countryCode = requestData["clientCountryName"] as? String,
                let datetime = requestData["datetime"] as? String
            {
                // Converting ISO 8601 string to a string in local time
                let date = isoFormatter.date(from:datetime)!
                let request: Request = Request(
                    action: action.uppercased(),
                    origin: ip,
                    countryCode: countryCode,
                    time: stringFormatter.string(from: date))
                requests.append(request)
            }
        }
        
        return requests
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
