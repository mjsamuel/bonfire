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
    
//    private var name: String = ""
//    private var content: String = ""
//    private var dnsID: String = ""

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        name = selectedDNS.name
//        content = selectedDNS.content
//        dnsID = selectedDNS.id!
        
        nameLabel.text = selectedDNS?.name
        contentTextField.text = selectedDNS?.content
    }
    
    /* if the data has been successfully passed to the API, then the user will simply been taken back to the main DNS view. If not, they will see an error (error message TBD) and must acknowledge the error by pressing OK before returning back to the modify dns view */
    @IBAction func updateDNS(_ sender: Any) {
        selectedDNS!.content = self.contentTextField.text!
        bonfire.cloudflare?.updateDNS(dnsRecord:selectedDNS!, completion: { success in
            if success == true {
//                self.content = self.contentTextField.text!
                self.delegate?.userDidEnterInformation(dns: self.selectedDNS!)
                self.navigationController?.popViewController(animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "Insert error message here", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        })
    }
}
