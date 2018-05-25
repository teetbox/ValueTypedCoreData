//
//  UserMO+CoreDataClass.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UserMO)
public class UserMO: NSManagedObject {}

extension UserMO: ManagedObjectProtocol {
    func toEntity() -> User? {
        return User(uuid: uuid, username: username, email: email)
    }
}

extension User: ManagedObjectConvertible {
    func toManagedObject(context: NSManagedObjectContext) -> UserMO? {
        let user = UserMO.getOrCreate(withId: uuid, in: context)
        user.username = username
        user.email = email
        return user
    }
}
