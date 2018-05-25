//
//  NotesDataModel.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol NotesDataModelProtocol {
    func fetchNotes(for book: Book, completion: @escaping ([Note]?) -> Void)
    func delete(note: Note, completion: @escaping (Error?) -> Void)
}

class NotesDataModel: NotesDataModelProtocol {
    
    let serviceEngine: CoreDataServiceProtocol
    
    init(engine: CoreDataServiceProtocol = CoreDataEngine()) {
        self.serviceEngine = engine
    }
    
    func fetchNotes(for book: Book, completion: @escaping ([Note]?) -> Void) {
        let predicate = NSPredicate(format: "uuid = %@", book.uuid)
        
        serviceEngine.fetch(with: predicate) { (result: Result<[Book]>) in
            switch result {
            case .success(let items):
                completion(items.first?.notes)
            case .failure(let error):
                NSLog("Fetch notes error: \(error)")
                completion(nil)
            }
        }
    }
    
    func delete(note: Note, completion: @escaping (Error?) -> Void) {
        serviceEngine.delete(entities: [note]) { error in
            if let error = error {
                NSLog("Delete notes error: \(error)")
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
}
