//
//  DNSEditViewController.swift
//  Bonfire
//
//  Created by Dylan Sbogar on 4/9/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class DNSEditViewController: UIViewController {
    
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
            
            // saveButton.action = Cloudflare.updateDNS()
        }
    }
    
    func clickSave(src: UIBarButtonItem) {
        let alert = UIAlertController(title: "Error", message: "Insert error message here", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}
