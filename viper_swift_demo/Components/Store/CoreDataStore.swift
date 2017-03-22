//
//  CoreDataStore.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStore: NSObject {
    var persistentStoreCoordinator: NSPersistentStoreCoordinator?
    var managedObjectModel: NSManagedObjectModel?
    var managedObjectContext: NSManagedObjectContext?
    
    override init() {
        super.init()

        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)

        let domains = FileManager.SearchPathDomainMask.userDomainMask
        let directory = FileManager.SearchPathDirectory.documentDirectory
        
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        guard
            let applicationDocumentDirectory = FileManager.default.urls(for: directory, in: domains).last,
            let persistentStoreCoordinator = self.persistentStoreCoordinator
            else {
                return
        }
        
        let storeURL = applicationDocumentDirectory.appendingPathComponent("viper-seift.sqlite")
        do {
           try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: "", at: storeURL, options: options)
        } catch {
           print("failure")
        }
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext!.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext!.undoManager = nil
    }
    
    
    func fetchEntries(
        with predicate: NSPredicate,
        sortDescriptors: [Any],
        completion: @escaping ([ManagedTodoItem])->()) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoItem")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = Array<NSSortDescriptor>()
        
        managedObjectContext?.perform {
            do {
                let queryResults = try self.managedObjectContext?.fetch(fetchRequest)
                let managedResults = queryResults as! [ManagedTodoItem]
                completion(managedResults)
                
            } catch {
                print("Fail to fetch \(predicate)")
            }
        }
    }
    
    func newTodoItem() -> ManagedTodoItem {
        let entityDescription = NSEntityDescription.entity(forEntityName: "TodoItem", in: managedObjectContext!)
        let newEntry = NSManagedObject(entity: entityDescription!, insertInto: managedObjectContext) as! ManagedTodoItem
        
        return newEntry
    }
    
    func save() {
        do {
            try managedObjectContext?.save()
        } catch {
            print("Fail to save managedObjectContext")
        }
    }
}








