//
//  SettingsTableTableViewController.swift
//  Bonfire
//
//  Created by Kurt Invernon on 24/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class SettingsTableTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
                return // We need a default but dont care
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
