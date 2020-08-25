//
//  RequestsController.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class RequestsController: UITableViewController {
    private let viewModel: RequestsViewModel = RequestsViewModel()
    private var requests: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestsIdentifier", for: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        let label1 = cell.viewWithTag(1001) as! UILabel
        label.text = "Row: "
        label1.text = String(indexPath.item + 1)
        
        return cell
    }
}
