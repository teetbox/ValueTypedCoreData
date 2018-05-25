//
//  ManagedObjectProtocol.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedObjectProtocol {
    associatedtype Entity
    func toEntity() -> Entity?
}

extension ManagedObjectProtocol where Self: NSManagedObject {
    
    static func getOrCreate(withId uuid: String, in context: NSManagedObjectContext) -> Self {
        let result = object(withId: uuid, in: context) ?? insert(in: context)
        result.setValue(uuid, forKey: "uuid")
        return result
    }
    
    static func object(withId uuid: String, in context: NSManagedObjectContext) -> Self? {
        let predicate = NSPredicate(format: "uuid == %@", uuid)
        return object(in: context, with: predicate, sortDescriptors: nil)
    }
    
    static func object(in context: NSManagedObjectContext, with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Self? {
        return fetch(from: context, with: predicate, sortDescriptors: sortDescriptors, fetchLimit: 1)?.first
    }
    
    static func insert(in context: NSManagedObjectContext) -> Self {
        return Self(context: context)
    }
    
    static func fetch(from context: NSManagedObjectContext, with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, fetchLimit: Int?) -> [Self]? {
        let fetchRequest = Self.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.returnsObjectsAsFaults = false
        
        if let limit = fetchLimit {
            fetchRequest.fetchLimit = limit
        }
        
        var result: [Self]?
        context.performAndWait { () -> Void in
            do {
                result = try context.fetch(fetchRequest) as? [Self]
            } catch {
                result = nil
                NSLog("Core Data fetch error: \(error)")
            }
        }
        return result
    }
    
}
