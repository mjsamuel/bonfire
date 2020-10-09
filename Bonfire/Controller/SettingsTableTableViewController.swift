//
//  SettingsTableTableViewController.swift
//  Bonfire
//
//  Created by Kurt Invernon on 24/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class SettingsTableTableViewController: UITableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    // Center and set the footer text
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if (section==1) {
            let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
            let app_name = Bundle.main.infoDictionary?["CFBundleName"] as! String
            (view as? UITableViewHeaderFooterView)?.textLabel?.textAlignment = .center       // Center the text
            (view as? UITableViewHeaderFooterView)?.textLabel?.text = app_name+"\nv"+ver     // Set the text
            (view as? UITableViewHeaderFooterView)?.textLabel?.sizeToFit()                   // Resize the label to fit text
            (view as? UITableViewHeaderFooterView)?.frame.size.height = 16 + ((view as? UITableViewHeaderFooterView)?.textLabel?.frame.size.height ?? 34)  // Update label height
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Fix the footer height on scroll
        self.tableView.footerView(forSection: 1)?.frame.size.height = 16 + (self.tableView.footerView(forSection: 1)?.textLabel?.frame.size.height ?? 34)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section==0) {
            switch indexPath.row {
            case 1:
                openCloudflare(deselectIndex: indexPath)
            case 2:
                logout(deselectIndex: indexPath)
            default:
                return // We need a default because Swift, but dont care
            }
        }
    }
    
    func openCloudflare(deselectIndex indexPath: IndexPath?) {
        UIApplication.shared.open(URL(string: "https://cloudflare.com")!, options: [:]) { (completed) in
            if (indexPath != nil) {
                self.tableView.deselectRow(at: indexPath!, animated: true)
            }
        }
    }
    
    func logout(deselectIndex indexPath: IndexPath?) {
        if (indexPath != nil) {
            self.tableView.deselectRow(at: indexPath!, animated: true)
        }
        // Logout
        Bonfire.sharedInstance.logout()
        // Send the user to the login screen
        if let tbc : MainTabBarController = (self.tabBarController as? MainTabBarController) {
            tbc.presentLoginView()
        }
    }

}
