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
    @IBOutlet weak var threatsLabel: UILabel!
    
    @IBOutlet weak var cachedLabel: UILabel!
    @IBOutlet weak var uncachedLabel: UILabel!
    @IBOutlet weak var percentCachedLabel: UILabel!
    
    @IBOutlet weak var countries: UITableView!

    @IBOutlet weak var cpmLabel: UILabel!
    @IBOutlet weak var cprLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFontSize()
        updateLabels()
    }
    
    /**
        Updates the text of all labels from the view model
     */
    private func updateLabels() {
        pageviewsLabel.text = viewModel.getPageviews()
        threatsLabel.text = viewModel.getThreats()
        cachedLabel.text = viewModel.getCached()
        uncachedLabel.text = viewModel.getUncached()
        percentCachedLabel.text = viewModel.getPercentCached() + "%"
        cpmLabel.text = "$" + viewModel.getCostPerMonth()
        cprLabel.text = "$" + viewModel.getCostPerRequest()
        
        let countries = viewModel.getCountries()
        for country in countries {
            print(country)
        }
    }
    
    /**
        Sets the font size of data point labels to fit within the width of their tile
     */
    private func setFontSize() {
        pageviewsLabel.adjustsFontSizeToFitWidth = true
        threatsLabel.adjustsFontSizeToFitWidth = true
        cachedLabel.adjustsFontSizeToFitWidth = true
        uncachedLabel.adjustsFontSizeToFitWidth = true
        percentCachedLabel.adjustsFontSizeToFitWidth = true
        cpmLabel.adjustsFontSizeToFitWidth = true
        cprLabel.adjustsFontSizeToFitWidth = true
    }
}
