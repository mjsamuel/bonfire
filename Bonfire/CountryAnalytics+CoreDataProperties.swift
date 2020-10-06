//
//  CountryAnalytics+CoreDataProperties.swift
//  Bonfire
//
//  Created by James on 6/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//
//

import Foundation
import CoreData


extension CountryAnalytics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryAnalytics> {
        return NSFetchRequest<CountryAnalytics>(entityName: "CountryAnalytics")
    }

    @NSManaged public var countryCode: String?
    @NSManaged public var numRequests: Int64
    @NSManaged public var zoneID: String?

}
