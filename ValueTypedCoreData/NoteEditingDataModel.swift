//
//  NoteEditingDataModel.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation

protocol NoteEditingDataModelProtocol {
    func save(_ note: Note, for book: Book, completion: @escaping (Error?) -> Void)
}

class NoteEditingDataModel: NoteEditingDataModelProtocol {
    
    let dataEngine: CoreDataServiceProtocol
    
    init(dateEngine: CoreDataServiceProtocol = CoreDataEngine()) {
        self.dataEngine = dateEngine
    }
    
    func save(_ note: Note, for book: Book, completion: @escaping (Error?) -> Void) {
        var notes = book.notes
        notes?.append(note)
        
        var book = book
        book.notes = notes
        
        dataEngine.update(entities: [book]) { error in
            completion(error)
        }
    }
    
}
