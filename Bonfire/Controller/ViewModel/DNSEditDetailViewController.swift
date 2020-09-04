//
//  DNSEditDetailViewController.swift
//  Bonfire
//
//  Created by Dylan Sbogar on 4/9/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class DNSEditDetailViewController: UIViewController {
    
    var selectedDNS:(name:String, type:String)?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedDNS = selectedDNS {
            nameTextField.text = selectedDNS.name
            contentTextField.text = selectedDNS.type
        }
    }
}
