//
//  AnalyticsViewController.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class AnalyticsViewController: UIViewController {
    
    private let viewModel: AnalyticsViewModel = AnalyticsViewModel()
    
    @IBOutlet weak var pageviewsLabel: UILabel!
    @IBOutlet weak var threatsLebel: UILabel!

    @IBOutlet weak var cachedLabel: UILabel!
    @IBOutlet weak var uncachedLabel: UILabel!
    @IBOutlet weak var percentCachedLabel: UILabel!
    
    @IBOutlet weak var firstCountryLabel: UILabel!
    @IBOutlet weak var secondCountryLabel: UILabel!
    @IBOutlet weak var thirdCountryLabel: UILabel!
    
    @IBOutlet weak var cpmLabel: UILabel!
    @IBOutlet weak var cprLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getAnalytics()
    }

}

