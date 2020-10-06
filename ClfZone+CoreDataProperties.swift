//
//  ClfZone+CoreDataProperties.swift
//  Bonfire
//
//  Created by James on 6/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//
//

import Foundation
import CoreData


extension ClfZone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClfZone> {
        return NSFetchRequest<ClfZone>(entityName: "ClfZone")
    }

    @NSManaged public var name: String?
    @NSManaged public var zoneID: String?

}
