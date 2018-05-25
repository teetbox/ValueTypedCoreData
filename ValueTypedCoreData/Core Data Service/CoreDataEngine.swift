//
//  CoreDataEngine.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    
    func fetch<Entity: ManagedObjectConvertible>(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, fetchLimit: Int?, completion: @escaping (Result<[Entity]>) -> Void)
    
    func update<Entity: ManagedObjectConvertible>(entities: [Entity], completion: @escaping (Error?) -> Void)
    
    func delete<Entity: ManagedObjectConvertible>(entities: [Entity], completion: @escaping (Error?) -> Void)
    
}

extension CoreDataServiceProtocol {
    func fetch<Entity: ManagedObjectConvertible>(with predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int? = nil, completion: @escaping (Result<[Entity]>) -> Void) {
        fetch(with: predicate, sortDescriptors: sortDescriptors, fetchLimit: fetchLimit, completion: completion)
    }
}

class CoreDataEngine: CoreDataServiceProtocol {
    
    let coreData: CoreDataManager
    
    init(coreData: CoreDataManager = CoreDataManager.shared) {
        self.coreData = coreData
    }
    
    func fetch<Entity>(with predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int? = nil, completion: @escaping (Result<[Entity]>) -> Void) where Entity : ManagedObjectConvertible {
        
        coreData.performForegroundTask { context in
            do {
                let fetchRequest = Entity.ManagedObject.fetchRequest()
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = sortDescriptors
                if let fetchLimit = fetchLimit {
                    fetchRequest.fetchLimit = fetchLimit
                }
                
                let results = try context.fetch(fetchRequest) as? [Entity.ManagedObject]
                let items = results?.compactMap { $0.toEntity() as? Entity } ?? []
                completion(.success(items))
            } catch {
                NSLog("Core Data fetch error: \(error)")
                completion(.failure(error))
            }
        }
    }

    func update<Entity>(entities: [Entity], completion: @escaping (Error?) -> Void) where Entity : ManagedObjectConvertible {
        
        coreData.performBackgroundTask { context in
            _ = entities.compactMap { $0.toManagedObject(context: context) }
            
            do {
                try context.save()
                completion(nil)
            } catch {
                NSLog("Core Data save error: \(error)")
                completion(error)
            }
        }
    }
    
    func delete<Entity>(entities: [Entity], completion: @escaping (Error?) -> Void) where Entity : ManagedObjectConvertible {
        
        coreData.performBackgroundTask { context in
            let objects = entities.compactMap { $0.toManagedObject(context: context) }
            
            for object in objects {
                context.delete(object)
            }
            
            do {
                try context.save()
                completion(nil)
            } catch {
                NSLog("Core Data delete error: \(error)")
                completion(error)
            }
        }
    }
    
}
