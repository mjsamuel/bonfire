//
//  DNSEditViewController.swift
//  Bonfire
//
//  Created by Dylan Sbogar on 4/9/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class DNSEditViewController: UIViewController {
    
    private let bonfire: Bonfire = Bonfire.sharedInstance
    weak var delegate: DNSDataDelegate? = nil
    var selectedDNS:DNS?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = selectedDNS?.name
        contentTextField.text = selectedDNS?.content
    }
    
    /* if the data has been successfully passed to the API, then the user will simply been taken back to the main DNS view. If not, they will see an error (error message TBD) and must acknowledge the error by pressing OK before returning back to the modify dns view */
    @IBAction func updateDNS(_ sender: Any) {
        // Set our current DNS object to the new content string.
        selectedDNS!.content = self.contentTextField.text!
        // Make request to CloudFlare to update to match our new DNS object values.
        bonfire.cloudflare?.updateDNS(dnsRecord:selectedDNS!, completion: { success in
            if success == true {
                self.delegate?.userDidEnterInformation(dns: self.selectedDNS!)
                self.navigationController?.popViewController(animated: true)
            } else {
                // This was unsuccessful, show an error alert to the user.
                let alert = UIAlertController(title: "Error", message: "An unknown error occured when attempting to update the DNS record with CloudFlare.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        })
    }
}
