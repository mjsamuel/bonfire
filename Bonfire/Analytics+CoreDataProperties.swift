//
//  Analytics+CoreDataProperties.swift
//  Bonfire
//
//  Created by James on 6/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//
//

import Foundation
import CoreData


extension Analytics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Analytics> {
        return NSFetchRequest<Analytics>(entityName: "Analytics")
    }

    @NSManaged public var numRequestsPerMonth: Int64
    @NSManaged public var numThreatsPerMonth: Int64
    @NSManaged public var numRequestsCaches: Int64
    @NSManaged public var numRequestsUncached: Int64
    @NSManaged public var flatCostPerMonth: Float
    @NSManaged public var costPerRequest: Float

}
