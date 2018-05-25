//
//  BookMO+CoreDataClass.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

@objc(BookMO)
public class BookMO: NSManagedObject {}

extension BookMO: ManagedObjectProtocol {
    func toEntity() -> Book? {
        var book = Book(id: uuid)
        book.title = title
        book.price = price
        book.publisher = publisher
        book.author = author?.toEntity()
        book.notes = (notes?.allObjects as? [NoteMO])?.compactMap { $0.toEntity() }
        return book
    }
}

extension Book: ManagedObjectConvertible {
    func toManagedObject(context: NSManagedObjectContext) -> BookMO? {
        let book = BookMO.getOrCreate(withId: uuid, in: context)
        book.title = title
        book.price = price ?? 9.9
        book.publisher = publisher
        book.author = author?.toManagedObject(context: context)
        if let notes = notes?.compactMap({ $0.toManagedObject(context: context) }) {
            book.notes = NSSet(array: notes)
        }
        return book
    }
}
