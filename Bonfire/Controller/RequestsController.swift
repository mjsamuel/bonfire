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
        
        // Need to set this to accomodate for IPv6 addresses.
        leftLabel.adjustsFontSizeToFitWidth = true
        
        let rightLabel = cell.viewWithTag(1001) as! UILabel
        let rightText: String = request.time
        rightLabel.text = rightText
        
        return cell
    }
    
    // Promts user to confirm banning the selected IP address
    func confirmAction(selectedAction :Action ,hostIP :String){
        
        // Create a message based off the selected action
        var actionMessage:String = selectedAction.rawValue
        
        // Modify the message for CAPTCHA challange for readability.
        if selectedAction == Action.CAPTCHAchallange{
            actionMessage = "CAPTCHA Challenge"
        }
        
        // Create the confirm dialogue box
        let confirmationAlert = UIAlertController(title: "Confirm \(actionMessage) for \(hostIP)?", message: selectedAction.description, preferredStyle: UIAlertControllerStyle.alert)
        
        // Add the OK option, and and update up
        confirmationAlert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (action: UIAlertAction!) in
            var host:HostAction = HostAction(action: selectedAction, hostIP: hostIP)
            // update the action state
            host.setAction(selectedAction: selectedAction)
            // Send the action to Clourflare
//            host.sendActionToCloudflare(selectedAction:selectedAction, hostIP:hostIP)
        }))
       
        // Add the cancle option
        confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // Do nothing
        }))
        
        // Display the confirmation dialogue box
        present(confirmationAlert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected request object from the selected row index.
        let request: Request = requests[indexPath.row]
        let hostIP: String = request.origin
        
        print("DEBUG: host IP addres selected: \(hostIP)")
        
        // -- Handle action sheet --
        
        // Define the Action Sheet
        let actionSheet = UIAlertController(title: "Chose action for \(hostIP)", message:nil, preferredStyle: .actionSheet)
        
        // Define the Ban Action
        let ban = UIAlertAction(title: Action.ban.rawValue, style: .destructive){ action in
            
            // Send off the action to the confirmation handler
            let selectedAction:Action = Action.ban
            self.confirmAction(selectedAction: selectedAction, hostIP:hostIP)
        }
        
        
        // Define the JS Challenge Action
        let jsChallenge = UIAlertAction(title: "JS Challenge", style: .default){ action in
            
            // Send off the action to the confirmation handler
            let selectedAction:Action = Action.JSchallange
            self.confirmAction(selectedAction: selectedAction, hostIP:hostIP)
        }


        // Define the CAPTCHA Challenge Action
        let captchaChallenge = UIAlertAction(title: "CAPTCHA Challenge", style: .default){ action in
            
            // Send off the action to the confirmation handler
            let selectedAction:Action = Action.CAPTCHAchallange
            self.confirmAction(selectedAction: selectedAction, hostIP:hostIP)
        }
        
        // Define the Allow action
        let allow = UIAlertAction(title: "Allow", style: .default){ action in
            
            // Send off the action to the confirmation handler
            let selectedAction:Action = Action.allow
            self.confirmAction(selectedAction: selectedAction, hostIP:hostIP)
        }
        
        // Define an option to Cancel
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add actions to the action sheet.
        actionSheet.addAction(jsChallenge)
        actionSheet.addAction(captchaChallenge)
        actionSheet.addAction(allow)
        actionSheet.addAction(ban)
        actionSheet.addAction(cancel)

        
    
        
        present(actionSheet, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// NOTE FOR JAMES:
// need to decide what to do for the object when using the memeory database.
