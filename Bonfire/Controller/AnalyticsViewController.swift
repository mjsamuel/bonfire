//
//  AnalyticsViewController.swift
//  Bonfire
//
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class AnalyticsViewController: UIViewController, UITableViewDataSource {
    private let viewModel: AnalyticsViewModel = AnalyticsViewModel()
    private var countries: [Country] = []
    
    @IBOutlet weak var pageviewsLabel: UILabel!
    @IBOutlet weak var threatsLabel: UILabel!
    
    @IBOutlet weak var cachedLabel: UILabel!
    @IBOutlet weak var uncachedLabel: UILabel!
    @IBOutlet weak var percentCachedLabel: UILabel!
    
    @IBOutlet weak var countriesTable: UITableView!
    
    @IBOutlet weak var cpmLabel: UILabel!
    @IBOutlet weak var cprLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesTable.dataSource = self
        
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
        
        self.countries = viewModel.getCountries()
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
    
    // Table view functions for the 'top countries' tile
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryIdentifier", for: indexPath)
        let country: Country = countries[indexPath.row]

        let countriesLabel = cell.viewWithTag(1000) as! UILabel
        countriesLabel.text = country.name

        let noRequestsLabel = cell.viewWithTag(1001) as! UILabel
        noRequestsLabel.text = String(country.noRequests)

        return cell
    }
}
