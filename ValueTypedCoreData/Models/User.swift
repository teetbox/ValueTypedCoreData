//
//  User.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

struct User {
    let uuid: String
    var username: String?
    var email: String?
}

extension User {
    init(id: String) {
        uuid = id
        username = nil
        email = nil
    }
}
