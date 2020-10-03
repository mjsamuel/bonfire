//
//  HostActions.swift
//  Bonfire
//
//  Created by James on 22/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation

enum Action: String {
    case allow = "Allow" // allows the host to the site.
    case JSchallange = "JS challenge" // wait 5 seconds to determine if the host is a legit user.
    case CAPTCHAchallange = "CAPTCHA challenge" // shows the host a CAPTCHA before being allowed to the site
    case ban = "Ban" // bans the host
    case normal = "Default"
    
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
    
    // constructor
    init(action: Action, hostIP: String) {
        self.ipAddress = hostIP
        self.action = action
    }
    
    mutating func setAction(selectedAction: Action) {
        // Since the action is changing for the object we can also make the API call to Cloudflare. Only call if the action is different to the current state.
        if(selectedAction != self.action){
            sendActionToCloudflare(selectedAction: selectedAction, hostIP: self.ipAddress)
        }
        
        // Update the action
        self.action = selectedAction
    }
    
    // Send API calls to Clourflare based on the action
    func sendActionToCloudflare(selectedAction: Action, hostIP:String){
        
        if (selectedAction == Action.normal) {
            print("DEBUG: Sending API call to Cloudflare to remove any firewall rule (action)")
        } else {
            print("DEBUG: Sending API call to Cloudflare to: \(selectedAction) the IP: \(hostIP)")
        }
    }
    
    func getAction() -> Action {
        return self.action
    }
    
    func getIpAddress() -> String {
        return self.ipAddress
    }
    
}
