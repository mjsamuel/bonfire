//
//  CountryAnalytics+CoreDataProperties.swift
//  Bonfire
//
//  Created by James on 9/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//
//

import Foundation
import CoreData


extension CountryAnalytics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryAnalytics> {
        return NSFetchRequest<CountryAnalytics>(entityName: "CountryAnalytics")
    }

    @NSManaged public var countryName: String?
    @NSManaged public var numRequests: Int64
    @NSManaged public var zoneID: String?

}
