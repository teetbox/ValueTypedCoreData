//
//  StoresDataModel.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol StoresDataModelProtocol {
    func fetchStores(completion: @escaping ([Store]?) -> Void)
}

class StoresDataModel: StoresDataModelProtocol {
    
    let serviceEngine: CoreDataServiceProtocol
    
    init(engine: CoreDataServiceProtocol = CoreDataEngine()) {
        self.serviceEngine = engine
    }

    func fetchStores(completion: @escaping ([Store]?) -> Void) {
        let sort = NSSortDescriptor(key: "brand", ascending: true)
        serviceEngine.fetch(sortDescriptors: [sort]) { (result: Result<[Store]>) in
            switch result {
            case .success(let items):
                completion(items)
            case .failure(let error):
                NSLog("Fetch stores error: \(error)")
                completion(nil)
            }
        }
    }
    
}
