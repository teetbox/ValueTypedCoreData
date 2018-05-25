//
//  CoreDataManager.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ValueTypedCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let context:NSManagedObjectContext = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            block(self.viewContext)
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func resetData() {
        let entities = persistentContainer.managedObjectModel.entities
        entities.compactMap ({ $0.name }).forEach(clearEntity)
        
        createDummyData()
    }
    
    private func clearEntity(_ name: String) {
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let batchDelete = NSBatchDeleteRequest(fetchRequest: deleteRequest)
        
        do {
            try viewContext.execute(batchDelete)
        } catch {
            NSLog("Batch delete error for \(name): \(error)")
        }
    }
    
    private func createDummyData() {
        let amazonStore = StoreMO(context: viewContext)
        amazonStore.uuid = UUID().uuidString
        amazonStore.brand = "Amazon"
        
        let safariStore = StoreMO(context: viewContext)
        safariStore.uuid = UUID().uuidString
        safariStore.brand = "Safari"
        
        let charles = AuthorMO(context: viewContext)
        charles.uuid = UUID().uuidString
        charles.name = "Charles Duhigg"
        
        let thePowerOfHabit = BookMO(context: viewContext)
        thePowerOfHabit.uuid = UUID().uuidString
        thePowerOfHabit.title = "The Power of Habit"
        thePowerOfHabit.price = 13.60
        thePowerOfHabit.publisher = "Random House"
        thePowerOfHabit.author = charles
        
        let nassim = AuthorMO(context: viewContext)
        nassim.uuid = UUID().uuidString
        nassim.name = "Nassim Nicholas Taleb"
        
        let theBlackSwan = BookMO(context: viewContext)
        theBlackSwan.uuid = UUID().uuidString
        theBlackSwan.title = "The Black Swan"
        theBlackSwan.price = 12.23
        theBlackSwan.publisher = "Random House"
        theBlackSwan.author = nassim
        
        amazonStore.addToBooks(thePowerOfHabit)
        amazonStore.addToBooks(theBlackSwan)
        
        let chris = AuthorMO(context: viewContext)
        chris.uuid = UUID().uuidString
        chris.name = "Chris Eidhof"
        
        let advancedSwift = BookMO(context: viewContext)
        advancedSwift.uuid = UUID().uuidString
        advancedSwift.title = "Advanced Swift"
        advancedSwift.price = 39.00
        advancedSwift.publisher = "Createspace Independent Pub"
        advancedSwift.author = chris
        
        let functionalSwift = BookMO(context: viewContext)
        functionalSwift.uuid = UUID().uuidString
        functionalSwift.title = "Functional Swift"
        functionalSwift.price = 47.00
        functionalSwift.publisher = "Florian Kugler"
        functionalSwift.author = chris
        
        let florian = AuthorMO(context: viewContext)
        florian.uuid = UUID().uuidString
        florian.name = "Florian Kugler"
        
        let coreData = BookMO(context: viewContext)
        coreData.uuid = UUID().uuidString
        coreData.title = "Core Data"
        coreData.price = 39.00
        coreData.publisher = "Createspace Independent Pub"
        coreData.author = florian
        
        safariStore.addToBooks(advancedSwift)
        safariStore.addToBooks(functionalSwift)
        safariStore.addToBooks(coreData)
        
        let userA = UserMO(context: viewContext)
        userA.uuid = UUID().uuidString
        userA.username = "User A"
        userA.email = "a@user.com"
        
        let userB = UserMO(context: viewContext)
        userB.uuid = UUID().uuidString
        userB.username = "User B"
        userB.email = "b@user.com"
        
        let userC = UserMO(context: viewContext)
        userC.uuid = UUID().uuidString
        userC.username = "User C"
        userC.email = "c@user.com"
        
        let userD = UserMO(context: viewContext)
        userD.uuid = UUID().uuidString
        userD.username = "User D"
        userD.email = "d@user.com"
        
        let userE = UserMO(context: viewContext)
        userE.uuid = UUID().uuidString
        userE.username = "User E"
        userE.email = "e@user.com"
        
        let theBlackSwanNoteA = NoteMO(context: viewContext)
        theBlackSwanNoteA.uuid = UUID().uuidString
        theBlackSwanNoteA.content = "I am not smart enough to estimate the number of people who have been given the capacity to look at the world from an entirely unique and yet vital perspective, but Nassim Taleb is definitely one of them."
        theBlackSwanNoteA.createdAt = Date()
        theBlackSwanNoteA.user = userE
        
        let theBlackSwanNoteB = NoteMO(context: viewContext)
        theBlackSwanNoteB.uuid = UUID().uuidString
        theBlackSwanNoteB.content = "I am not sure how to describe it, but reading this book is definitely an Experience."
        theBlackSwanNoteB.createdAt = Date()
        theBlackSwanNoteB.user = userD
        
        theBlackSwan.addToNotes(theBlackSwanNoteA)
        theBlackSwan.addToNotes(theBlackSwanNoteB)
        
        let thePowerOfHabitNoteA = NoteMO(context: viewContext)
        thePowerOfHabitNoteA.uuid = UUID().uuidString
        thePowerOfHabitNoteA.content = "Best seller for New York Times, Los Angeles Times, US Today."
        thePowerOfHabitNoteA.createdAt = Date()
        thePowerOfHabitNoteA.user = userB
        
        let thePowerOfHabitNoteB = NoteMO(context: viewContext)
        thePowerOfHabitNoteB.uuid = UUID().uuidString
        thePowerOfHabitNoteB.content = "This book helps us understand how habits are formed and how we can use them to our benefit, change them when we need to and replace them when necessary."
        thePowerOfHabitNoteB.createdAt = Date()
        thePowerOfHabitNoteB.user = userD
        
        thePowerOfHabit.addToNotes(thePowerOfHabitNoteA)
        thePowerOfHabit.addToNotes(thePowerOfHabitNoteB)
        
        let coreDataNoteA = NoteMO(context: viewContext)
        coreDataNoteA.uuid = UUID().uuidString
        coreDataNoteA.content = "Core Data is cool"
        coreDataNoteA.createdAt = Date()
        coreDataNoteA.user = userA
        
        let coreDataNoteB = NoteMO(context: viewContext)
        coreDataNoteB.uuid = UUID().uuidString
        coreDataNoteB.content = "Core Data could do the data persistency work, but it's power is more than that."
        coreDataNoteB.createdAt = Date()
        coreDataNoteB.user = userB
        
        let coreDataNoteC = NoteMO(context: viewContext)
        coreDataNoteC.uuid = UUID().uuidString
        coreDataNoteC.content = "I like to use Core Data, but I want my models are value typed."
        coreDataNoteC.createdAt = Date()
        coreDataNoteC.user = userA
        
        coreData.addToNotes(coreDataNoteA)
        coreData.addToNotes(coreDataNoteB)
        coreData.addToNotes(coreDataNoteC)
        
        let functionalSwiftNoteA = NoteMO(context: viewContext)
        functionalSwiftNoteA.uuid = UUID().uuidString
        functionalSwiftNoteA.content = "Swift language supports functional programming."
        functionalSwiftNoteA.createdAt = Date()
        functionalSwiftNoteA.user = userA
        
        let functionalSwiftNoteB = NoteMO(context: viewContext)
        functionalSwiftNoteB.uuid = UUID().uuidString
        functionalSwiftNoteB.content = "This is the advanced feature in Swift."
        functionalSwiftNoteB.createdAt = Date()
        functionalSwiftNoteB.user = userB
        
        functionalSwift.addToNotes(functionalSwiftNoteA)
        functionalSwift.addToNotes(functionalSwiftNoteB)
        
        let advancedSwiftNoteA = NoteMO(context: viewContext)
        advancedSwiftNoteA.uuid = UUID().uuidString
        advancedSwiftNoteA.content = "Talk about advanced concepts in Swift programming."
        advancedSwiftNoteA.createdAt = Date()
        advancedSwiftNoteA.user = userC
        
        advancedSwift.addToNotes(advancedSwiftNoteA)
        
        saveContext()
    }
    
}
