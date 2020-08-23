//
//  HostActionController.swift
//  Bonfire
//
//  Created by James on 22/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit
class HostActionController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func test(_ sender: Any) {
        print("hello world")
    }
    
    var host = HostAction(ipAddress: 1)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // return number 'sections' in a row.
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return host.getActions()[row] // defie what text should be in each row.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return host.getActions().count // how many rows we want in the picker.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(host.getActions()[row])
    }
    
    @IBOutlet weak var picker: UIPickerView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
