//
//  UserMO+CoreDataProperties.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "UserMO")
    }

    @NSManaged public var uuid: String
    @NSManaged public var email: String?
    @NSManaged public var username: String?
    @NSManaged public var notes: Set<NoteMO>?

}

// MARK: Generated accessors for notes
extension UserMO {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: NoteMO)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: NoteMO)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}
