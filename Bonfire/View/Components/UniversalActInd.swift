//
//  UniversalActInd.swift
//  Bonfire
//
//  Created by Kurt Invernon on 5/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class UniversalActInd: UIViewController {

    @IBOutlet var actInd: UIActivityIndicatorView!
    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        containerView.alpha = 0.0
        super.viewWillAppear(animated)
        actInd.startAnimating()
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.alpha = 1.0
        })
    }
    
    public func fadeAway(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.alpha = 0.0
        }) { finished in
            self.actInd.stopAnimating()
            completion()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.actInd.stopAnimating()
    }
    
    
    class func viewController() -> UniversalActInd {
        return UIStoryboard(name: "UniversalActInd", bundle: nil).instantiateViewController(withIdentifier: "UniversalActInd") as! UniversalActInd
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
