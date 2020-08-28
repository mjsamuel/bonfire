//
//  RequestsController.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class RequestsController: UITableViewController {
    private let viewModel: RequestsViewModel = RequestsViewModel()
    private var requests: [Request] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTable()
    }
    
    func updateTable() {
        self.requests = viewModel.getRequests()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestsIdentifier", for: indexPath)
        
        let request: Request = requests[indexPath.row]
        
        let leftLabel = cell.viewWithTag(1000) as! UILabel
        // Creating an attributed string so that a section of the label can be bold
        let attributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let leftText = NSMutableAttributedString(string: request.action, attributes: attributes)
        let requestInfo = " - \(request.origin) (\(request.countryCode))"
        leftText.append(NSMutableAttributedString(string: requestInfo))
        leftLabel.attributedText = leftText

        let rightLabel = cell.viewWithTag(1001) as! UILabel
        let rightText: String = request.time
        rightLabel.text = rightText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected request object from the selected row index.
        let request: Request = requests[indexPath.row]
        let hostIP: String = request.origin
        
        print("DEBUG: host IP addres selected: \(hostIP)")
        // Ready to handle action sheet
    }

}
