//
//  MainTabBarController.swift
//  Bonfire
//
//  Created by Kurt Invernon on 2/9/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // If user is not logged in display login view
        let bf = Bonfire.sharedInstance
        
        // As of now, because we are not using any storage, this will always be true
        if (bf.cloudflare != nil && !bf.cloudflare!.isLoggedIn) {
            presentLoginView()
        }
    }
    
    public func presentLoginView() {
        performSegue(withIdentifier: "PresentLoginSegue", sender: nil)
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
