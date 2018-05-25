//
//  Store.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

struct Store {
    let uuid: String
    var brand: String?
    var books: [Book]?
}

extension Store {
    init(id: String) {
        uuid = id
        brand = nil
        books = nil
    }
}
