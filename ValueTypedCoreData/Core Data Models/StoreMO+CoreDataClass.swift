//
//  StoreMO+CoreDataClass.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

@objc(StoreMO)
public class StoreMO: NSManagedObject {}

extension StoreMO: ManagedObjectProtocol {
    func toEntity() -> Store? {
        var store = Store(id: uuid)
        store.brand = brand
        store.books = (books?.allObjects as? [BookMO])?.compactMap { $0.toEntity() }
        return store
    }
}

extension Store: ManagedObjectConvertible {
    func toManagedObject(context: NSManagedObjectContext) -> StoreMO? {
        let store = StoreMO.getOrCreate(withId: uuid, in: context)
        store.brand = brand
        if let books = books?.compactMap({ $0.toManagedObject(context: context) }) {
            store.books = NSSet(array: books)
        }
        return store
    }
}
