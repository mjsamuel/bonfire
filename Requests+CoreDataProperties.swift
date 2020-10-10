//
//  Requests+CoreDataProperties.swift
//  Bonfire
//
//  Created by James on 10/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//
//

import Foundation
import CoreData


extension Requests {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Requests> {
        return NSFetchRequest<Requests>(entityName: "Requests")
    }

    @NSManaged public var action: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var ipAddress: String?
    @NSManaged public var requestID: String?
    @NSManaged public var time: String?

}
