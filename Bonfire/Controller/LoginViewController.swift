//
//  LoginViewController.swift
//  Bonfire
//
//  Created by Kurt Invernon on 28/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var emailField: TextFieldWithInsets!
    @IBOutlet var keyField: TextFieldWithInsets!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Assign delegates for both textfields to self to allow handling textFieldShouldReturn
        keyField.delegate = self
        emailField.delegate = self
    }
    
    @IBAction func emailTextChanged(_ sender: Any) {
        // Update the state of the button as required
        updateButtonState(loginButton)
    }
    
    @IBAction func keyTextChanged(_ sender: Any) {
        // Update the state of the button as required
        updateButtonState(loginButton)
    }
    
    @IBAction func tryLogin(_ sender: UIButton) {
        // Check if both fields contain values
        if (isEntryValid()) {
            // Reset any modified button alpha
            sender.alpha = 1.0
            // Update the Bonfire singleton
            Bonfire.sharedInstance.login(email: emailField.text!, apiKey: keyField.text!)
            // Dismiss the login view
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func touchDownLogin(_ sender: UIButton) {
        // Change the alpha of the button to indicate button down
        sender.alpha = 0.8
    }
    
    @IBAction func touchUpLogin(_ sender: UIButton) {
        // Change the alpha of the button to indicate button up
        sender.alpha = 1.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Handle return key presses and act accordingly:
        // If we are in the email field, change to the key field
        // If we aren't in the email field, try to login
        if (textField == emailField) {
            keyField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
            tryLogin(loginButton)
        }
        return false
    }
    
    private func updateButtonState(_ btn: UIButton) {
        // DRY: Don't Repeat Yourself!
        btn.isEnabled = isEntryValid()
    }
    
    private func isEntryValid() -> Bool {
        // Return a boolean which is true if both text fields have text
        return (
            emailField.text != nil &&
            keyField.text != nil &&
            emailField.text!.count > 0 &&
            keyField.text!.count > 0
        )
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
