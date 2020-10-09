//
//  DNSViewController.swift
//  Bonfire
//
//  Created by Dylan Sbogar on 29/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

// protocol used to send DNS data back
public protocol DNSDataDelegate: class {
    func userDidEnterInformation(dns: DNS)
}

class DNSViewController: UITableViewController, DNSDataDelegate {

    private let bonfire = Bonfire.sharedInstance
    private var viewModel = DNSViewModel()
    private var dnsData: [DNS] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTable()
    }
    
    func updateTable() {
        if (bonfire.currentZone != nil) {
            // Request the current DNS records from CloudFlare
            bonfire.cloudflare!.getDNS(zoneId: bonfire.currentZone!.getId(), completion: { data in
                // If data recieved successfully, update our stored data and reload table.
                if data != nil {
                    self.viewModel.updateData(data!)
                    self.dnsData = self.viewModel.getDNSData()
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dnsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dnsIdentifier", for: indexPath) as! DNSTableCell
        
        let dnsRecord: DNS = dnsData[indexPath.row]
        
        cell.dnsRecord = dnsRecord
        
        let nameLabel = cell.viewWithTag(1000) as! UILabel
        let nameText: String = dnsRecord.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.text = nameText
        
        let typeLabel = cell.viewWithTag(1001) as! UILabel
        let typeText: String = dnsRecord.type
        typeLabel.text = typeText
        
        let contentLabel = cell.viewWithTag(1002) as! UILabel
        let contentText: String = dnsRecord.content
        contentLabel.text = contentText
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editDNSSegue" {
            guard let selectedRow = self.tableView.indexPathForSelectedRow
                else {return}
            let cell = self.tableView.cellForRow(at: selectedRow) as! DNSTableCell
            let destination = segue.destination as? DNSEditViewController
            destination?.selectedDNS = cell.dnsRecord!
            destination?.delegate = self
        } else if segue.identifier == "newDNSSegue" {
            let destination = segue.destination as? DNSNewViewController
            destination?.delegate = self
        }
    }
    
    func userDidEnterInformation(dns: DNS) {
        var data = dns
        
        // Filtering the array to remove the item if editing
        // If not editing this will return the same array
        dnsData = dnsData.filter {
            if ($0.name == data.name) {
                data.type = $0.type
            }
            
            return $0.name != data.name
        }
        dnsData.insert(data, at: 0)
        tableView.reloadData()
    }
}
