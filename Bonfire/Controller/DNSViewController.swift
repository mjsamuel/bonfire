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
    private var dnsRecords: [DNS] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTable()
    }
    
    func updateTable() {
        self.dnsRecords = viewModel.getDNS()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        return dnsRecords.count()
//         NOTE: DOES NOT WORK??
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dnsIdentifier", for: indexPath)
        
        let test: DNS = dnsRecords[indexPath.row]
        //        Fatal error: Index out of range?
        
        let nameLabel = cell.viewWithTag(1000) as! UILabel
        let typeLabel = cell.viewWithTag(1001) as! UILabel
        
        nameLabel.text = String(test.name)
        typeLabel.text = String(test.type)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

