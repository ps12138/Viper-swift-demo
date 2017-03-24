//
//  RealmStore.swift
//  viper_swift_demo
//
//  Created by PSL on 3/22/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import RealmSwift

class RealmStore {
    
    /// fetch image by urlStr
    public func fetchEntries(
        with predicate: NSPredicate,
        completion: ([TodoItem])->()) {
        
        var todoItems = Array<TodoItem>()
        guard let results = self.search(todoItem: predicate) else {
            completion(todoItems)
            //print("Realm.M: fail to object for \(predicate)")
            return
        }
        for element in results {
            let todoItem = TodoItem(from: element)
            todoItems.append(todoItem)
        
        }
        completion(todoItems)
    }
    
    func save(_ entry: TodoItem) {
        self.setObject(with: entry)
    }
    
    func remove(todoItem entry: TodoItem) -> Bool {
        return removeObject(todoItem: entry)
    }
    
    func remove(by primaryKey: String) -> Bool {
        return removeObject(key: primaryKey)
    }
    
    
    
    /// add obj
    private func setObject(with entry: TodoItem) {
        
        let newModel = RealmTodoItem(from: entry)
        do {
            let realm = try Realm()
            try realm.write(){
                realm.add(newModel, update: true)
            }
            print("Realm.M: add to realm")
        } catch let error as NSError{
            print("Realm.M: fail to add \(error.localizedDescription)")
        }
    }
    
    
    /// remove by entry
    private func removeObject(todoItem entry: TodoItem) -> Bool {
        let predicate = NSPredicate(format: "mainKey == %@", entry.primaryKey as NSString)
        guard let results = self.search(todoItem: predicate) else {
            print("Realm.M: fail to remove object for \(predicate)")
            return false
        }
        for element in results {
            remove(obj: element)
        }
        return true
    }
    
    /// remove by primarykey
    private func removeObject(key primaryKey: String) -> Bool {
        let predicate = NSPredicate(format: "mainKey == %@", primaryKey as NSString)
        guard let results = self.search(todoItem: predicate) else {
            print("Realm.M: fail to remove key for \(predicate)")
            return false
        }
        for element in results {
            remove(obj: element)
        }
        return true
    }
    
    
    /// remove all image
    public func removeAllObjects() {
        do {
            let realm = try Realm()
            try realm.write(){
                realm.deleteAll()
            }
            print("Realm.M: remove all")
        } catch let error as NSError{
            print("Realm.M: fail to remove all \(error.localizedDescription)")
        }
    }
}


private extension RealmStore {
    
    /// search model for key
    func search(todoItem predicate: NSPredicate) -> [RealmTodoItem]? {
        
        do {
            let realm = try Realm()
            let resModels = realm.objects(RealmTodoItem.self).filter(predicate).sorted(byKeyPath: "date", ascending: true)
            if !resModels.isEmpty {
                print("Realm.M: fetch in Realm")
                return Array<RealmTodoItem>(resModels)
            }
        } catch let error as NSError {
            print("Realm.M: fail search - \(error.localizedDescription)")
            
        }
        return nil
    }
    
    /// remove model for key
    func remove(obj: RealmTodoItem) {
        do {
            let realm = try Realm()
            try realm.write(){
                realm.delete(obj)
            }
            print("Realm.M: remove")
        } catch let error as NSError{
            print("Realm.M: fail to remove \(error.localizedDescription)")
        }
    }
}



