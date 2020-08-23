//
//  HostActions.swift
//  Bonfire
//
//  Created by James on 22/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

enum Action: String{
    case allow = "Allow" // allows the host to the site.
    case JSchallange = "JS challenge" // wait 5 seconds to determine if the host is a legit user.
    case CAPTCHAchallange = "CAPTCHA challenge" // shows the host a CAPTCHA before being allowed to the site
    case ban = "Ban" // bans the host
    
    static let allValues = [allow, JSchallange, CAPTCHAchallange, ban]
    
    // Describes what each action will do.
    var description:String {
        switch self {
            // Inorder of impact to the user.
            case .allow:return "Ensures that an IP address will never be blocked from accessing your website. The IP may still be mitigated if part of a DDoS attack. Only use for verified IPs that you trust!"
            case .JSchallange:return "The JavaScript challenge page requires the visitor to wait 5 seconds while Cloudflare determines if the visitor is coming from a real browser. The challenge requires the visitor's browser to answer a math problem which takes a bit of time to compute. Once successfully answered, the browser will be remembered and won't be challenged again."
            case .CAPTCHAchallange:return "Specified IP addresses will be shown a CAPTCHA before being allowed to access your website"
            case .ban:return "Ensures that an IP address will never be allowed to access your website"
        }
    }
    
    
    var toString:[String]{
        return ["a", "b", "c"]
    }
    
    
}


struct HostAction{
    private var actions: [String] = ["Ban", "Challange", "JS Challange"]
    private var rateLimit: Int = 50     // Amount of requst to allow before being flaged for action
    private var rateLimitTime: Int = 60 // Time span of requests to be grouped into.
    private var ipAddress: Int
    
    // constructor
    init(ipAddress: Int){
        self.ipAddress = ipAddress
    }
    
    // getter for the list of actions available
    func getActions() -> [String]{
        return actions
    }
    
    
    
}
