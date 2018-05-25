//
//  BooksDataModel.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol BooksDataModelProtocol {
    func fetchBooks(for store: Store, completion: @escaping ([Book]?) -> Void)
}

class BooksDataModel: BooksDataModelProtocol {
    
    let serviceEngine: CoreDataServiceProtocol
    
    init(engine: CoreDataServiceProtocol = CoreDataEngine()) {
        self.serviceEngine = engine
    }
    
    func fetchBooks(for store: Store, completion: @escaping ([Book]?) -> Void) {
        let predicate = NSPredicate(format: "store.uuid = %@", store.uuid)
        
        serviceEngine.fetch(with: predicate) { (result: Result<[Book]>) in
            switch result {
            case .success(let items):
                completion(items)
            case .failure(let error):
                NSLog("Fetch books error: \(error)")
                completion(nil)
            }
        }
    }
    
}
