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
        let fetchRequest = Self.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid)
        fetchRequest.sortDescriptors = nil
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.fetchLimit = 1
        
        var result: [Self]?
        context.performAndWait {
            do {
                result = try context.fetch(fetchRequest) as? [Self]
            } catch {
                result = nil
                NSLog("Core Data fetch error: \(error)")
            }
        }
        
        // Return the existing object
        if let object = result?.first {
            return object
        }
        
        // Return the new created one
        let object = Self(context: context)
        object.setValue(uuid, forKey: "uuid")
        return object
    }
    
}
