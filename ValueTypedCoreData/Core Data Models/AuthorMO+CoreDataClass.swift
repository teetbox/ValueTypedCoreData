//
//  AuthorMO+CoreDataClass.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AuthorMO)
public class AuthorMO: NSManagedObject {}

extension AuthorMO: ManagedObjectProtocol {
    func toEntity() -> Author? {
        return Author(uuid: uuid, name: name)
    }
}

extension Author: ManagedObjectConvertible {
    func toManagedObject(context: NSManagedObjectContext) -> AuthorMO? {
        let author = AuthorMO.getOrCreate(withId: uuid, in: context)
        author.name = name
        return author
    }
}
