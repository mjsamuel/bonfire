//
//  DNSNewViewController.swift
//  Bonfire
//
//  Created by Dylan Sbogar on 4/9/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class DNSNewViewController: UIViewController {
    
    private let bonfire: Bonfire = Bonfire.sharedInstance
    weak var delegate: DNSDataDelegate? = nil

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var ttlTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        ttlTextField.keyboardType = .numberPad
    }
    

    @IBAction func newDNS(_ sender: Any) {
        /* if the data has been successfully passed to the API, then the user will simply been taken back to the main DNS view. If not, they will see an error (error message TBD) and must acknowledge the error by pressing OK before returning automatically back to the new DNS view. */
        let success = bonfire.cloudflare?.newDNS()
        if success == true {
            let name: String = nameTextField.text!
            let content: String = contentTextField.text!
            let ttl: String = ttlTextField.text!
            delegate?.userDidEnterInformation(name: name, content: content, ttl: ttl)
            self.navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Insert error message here", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
