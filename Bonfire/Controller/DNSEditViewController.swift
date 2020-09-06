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
    var selectedDNS:(name:String, content:String)?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedDNS = selectedDNS {
            nameLabel.text = selectedDNS.name
            contentTextField.text = selectedDNS.content
        }
    }
    
    /* if the data has been successfully passed to the API, then the user will simply been taken back to the main DNS view. If not, they will see an error (error message TBD) and must acknowledge the error by pressing OK before returning back to the modify dns view */
    @IBAction func updateDNS(_ sender: Any) {
        let success = bonfire.cloudflare?.updateDNS()
        if success == true {
            performSegue(withIdentifier: "returnToDNS", sender: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Insert error message here", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
