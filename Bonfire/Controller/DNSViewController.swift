//
//  DNSViewController.swift
//  Bonfire
//
//  Created by Dylan Sbogar on 29/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class DNSViewController: UITableViewController {
    private let viewModel = DNSViewModel()
    private var dnsData: [DNS] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTable()
    }
    
    func updateTable() {
        self.dnsData = viewModel.getDNSData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dnsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dnsIdentifier", for: indexPath)
        
        let dnsRecord: DNS = dnsData[indexPath.row]
        
        let nameLabel = cell.viewWithTag(1000) as! UILabel
        let nameText: String = dnsRecord.name
        nameLabel.text = nameText
        
        let typeLabel = cell.viewWithTag(1001) as! UILabel
        let typeText: String = dnsRecord.type
        typeLabel.text = typeText
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedRow = self.tableView.indexPathForSelectedRow
            else {return}
        
        let destination = segue.destination as? DNSEditDetailViewController
        let selectedDNS = viewModel.getDNSData(byIndex: selectedRow.row)
        
//        destination?.selectedDNS = selectedDNS
    
    }
}
