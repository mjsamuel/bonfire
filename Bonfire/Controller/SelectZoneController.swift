//
//  SelectZoneController.swift
//  Bonfire
//
//  Created by Kurt Invernon on 24/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class SelectZoneController: UITableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the count of zones from the singleton
        return Bonfire.sharedInstance.zones?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set the cell label text to the relevant zone
        let cell = tableView.dequeueReusableCell(withIdentifier: "zoneListCell", for: indexPath)
        cell.textLabel?.text = Bonfire.sharedInstance.zones![indexPath.row].name // Set the text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Here we store the currently selected zone information
        Bonfire.sharedInstance.currentZone = Bonfire.sharedInstance.zones![indexPath.row]
        self.dismiss(animated: true, completion: nil)
    }

}
