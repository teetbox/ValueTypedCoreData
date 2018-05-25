//
//  Note.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

struct Note {
    let uuid: String
    var content: String?
    var createdAt: Date?
    var user: User?
}

extension Note {
    init(id: String) {
        uuid = id
        content = nil
        createdAt = nil
        user = nil
    }
}
