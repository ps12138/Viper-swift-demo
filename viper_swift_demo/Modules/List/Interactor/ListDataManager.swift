//
//  ListDataManager.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


class ListDataManager {
    var dataStore: RealmStore?
    
    
    func todoItems(
        between startDate: Date,
        and endDate: Date,
        completion: @escaping ([TodoItem]) -> Void) {
        
        let predicate = self.predicate(between: startDate, to: endDate)
        print(endDate.description)
        dataStore?.fetchEntries(with: predicate) { (entries) -> Void in
            let todoItemModels = entries
            completion(todoItemModels)
        }
    }
    
    func todoItems (
        from today: Date,
        completion: @escaping ([TodoItem]) -> Void) {
        
        let predicate = self.predicate(from: today)
        dataStore?.fetchEntries(with: predicate) { (entries) -> Void in
            let todoItemModels = entries
            completion(todoItemModels)
        }
    }
    
    func todoItems (
        before today: Date,
        completion: @escaping ([TodoItem]) -> Void) {
        
        let predicate = self.predicate(before: today)
        dataStore?.fetchEntries(with: predicate) { (entries) -> Void in
            let todoItemModels = entries
            completion(todoItemModels)
        }
    }
    
    func todoItems(by primaryKey: String, completion: @escaping ([TodoItem]) -> Void) {
        
        let predicate = self.predicate(by: primaryKey)
        print(predicate.description)
        dataStore?.fetchEntries(with: predicate) { (entries) -> Void in
            let todoItemModels = entries
            completion(todoItemModels)
        }
    }
    
    func removeItem(by primaryKey: String) -> Bool {
        if let res = dataStore?.remove(by: primaryKey) {
            return res
        }
        return false
    }
    
    
    
    
    
    
    // MARK: - private methods
    
    private func predicate(from leftDate: Date) -> NSPredicate {
        let calendar = Calendar.autoupdatingCurrent
        let begining = calendar.date(beginningOfDate: leftDate)
        
        let predicate = NSPredicate(format: "(date >= %@)", argumentArray: [begining as NSDate])
        return predicate
    }
    
    private func predicate(before leftDate: Date) -> NSPredicate {
        let calendar = Calendar.autoupdatingCurrent
        let begining = calendar.date(beginningOfDate: leftDate)
        
        let predicate = NSPredicate(format: "(date < %@)", argumentArray: [begining as NSDate])
        return predicate
    }
    
    private func predicate(between leftDate: Date, to rightDate: Date) -> NSPredicate {
        let calendar = Calendar.autoupdatingCurrent
        let begining = calendar.date(beginningOfDate: leftDate)
        let end = calendar.date(endOfDate: rightDate)
        
        let predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", argumentArray: [begining as NSDate, end as NSDate])
        return predicate
    }
    
    private func predicate(by primaryKey: String) -> NSPredicate {
        let predicate = NSPredicate(format: "mainKey == %@", argumentArray: [primaryKey])
        return predicate
    }
}









