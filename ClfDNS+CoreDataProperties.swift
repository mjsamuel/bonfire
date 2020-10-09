//
//  ClfDNS+CoreDataProperties.swift
//  Bonfire
//
//  Created by James on 7/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//
//

import Foundation
import CoreData


extension ClfDNS {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClfDNS> {
        return NSFetchRequest<ClfDNS>(entityName: "ClfDNS")
    }

    @NSManaged public var ipAddress: String?
    @NSManaged public var name: String?
    @NSManaged public var recordType: String?
    @NSManaged public var ttl: Int16

}
