//
//  Result.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
