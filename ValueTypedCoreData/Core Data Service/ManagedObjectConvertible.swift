//
//  ManagedObjectConvertible.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedObjectConvertible {
    associatedtype ManagedObject: NSManagedObject, ManagedObjectProtocol
    func toManagedObject(context: NSManagedObjectContext) -> ManagedObject?
}
