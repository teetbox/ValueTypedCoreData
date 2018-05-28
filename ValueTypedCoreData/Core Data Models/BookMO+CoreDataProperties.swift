//
//  BookMO+CoreDataProperties.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

extension BookMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookMO> {
        return NSFetchRequest<BookMO>(entityName: "BookMO")
    }

    @NSManaged public var uuid: String
    @NSManaged public var price: Double
    @NSManaged public var publisher: String?
    @NSManaged public var title: String?
    @NSManaged public var notes: Set<NoteMO>?
    @NSManaged public var author: AuthorMO?
    @NSManaged public var store: StoreMO?

}

// MARK: Generated accessors for notes
extension BookMO {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: NoteMO)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: NoteMO)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}
