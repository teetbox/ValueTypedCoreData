//
//  Author.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

struct Author {
    let uuid: String
    var name: String?
}

extension Author {
    init(id: String) {
        uuid = id
        name = nil
    }
}
