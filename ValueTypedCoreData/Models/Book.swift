//
//  Book.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

struct Book {
    let uuid: String
    var title: String?
    var price: Double?
    var publisher: String?
    var author: Author?
    var notes: [Note]?
}

extension Book {
    init(id: String) {
        uuid = id
        title = nil
        price = nil
        publisher = nil
        author = nil
        notes = nil
    }
}
