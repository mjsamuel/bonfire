//
//  Requests+CoreDataProperties.swift
//  Bonfire
//
//  Created by James on 6/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//
//

import Foundation
import CoreData


extension Requests {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Requests> {
        return NSFetchRequest<Requests>(entityName: "Requests")
    }

    @NSManaged public var method: String?
    @NSManaged public var ipAddress: String?
    @NSManaged public var time: String?
    @NSManaged public var action: String?

}
