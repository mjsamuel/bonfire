//
//  Bonfire.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//
import Foundation
import UIKit

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
            if self.cloudflare!.isLoggedIn {
                self.currentZone = zones[0]
            } else {
                // Show error alert no zones found or not valid creds
                self.showErrorAlert(title: "Login Failed", message: "Please confirm your email and API key. You must have atleast 1 zone configured in CloudFlare.")
            }
            completion(self.cloudflare!.isLoggedIn)
        })
    }
    
    /**
     Logs out a user and discards their credentials
     */
    public func logout() {
        cloudflare = nil
        zones = nil
        currentZone = nil
    }
    
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
