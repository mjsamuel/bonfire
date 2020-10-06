//
//  Account+CoreDataProperties.swift
//  Bonfire
//
//  Created by James on 6/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var email: String?
    @NSManaged public var zoneID: String?
    @NSManaged public var apiKey: String?

}
