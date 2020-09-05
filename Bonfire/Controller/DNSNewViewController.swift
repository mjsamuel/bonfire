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
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var ttlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ttlTextField.keyboardType = .numberPad
    }
    
    /* if the data has been successfully passed to the API, then the user will simply been taken back to the main DNS view. If not, they will see an error (error message TBD) and must acknowledge the error by pressing OK before returning automatically back to the new DNS view. */
    @IBAction func newDNS(_ sender: Any) {
        let success = bonfire.cloudflare?.newDNS()
        if success == true {
            performSegue(withIdentifier: "returnToDNS", sender: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Insert error message here", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
