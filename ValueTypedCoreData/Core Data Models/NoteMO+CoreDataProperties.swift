//
//  NoteMO+CoreDataProperties.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

extension NoteMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteMO> {
        return NSFetchRequest<NoteMO>(entityName: "NoteMO")
    }

    @NSManaged public var uuid: String
    @NSManaged public var createdAt: Date?
    @NSManaged public var content: String?
    @NSManaged public var user: UserMO?
    @NSManaged public var book: BookMO?

}
