//
//  ListDataManager.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


class ListDataManager {
    var coreDataStore: CoreDataStore?
    
    func todoItems(
        between startDate: Date,
        and endDate: Date,
        completion: @escaping ([TodoItemModel]) -> Void) {
        
        let calendar = Calendar.autoupdatingCurrent
        let begining = calendar.date(beginningOfDate: startDate)
        let end = calendar.date(endOfDate: endDate)
        
        let predicateString = "(date >= %@) AND (date <= %@)"
        let predicate = NSPredicate(format: predicateString, [begining, end])
        let sortDescriptors = Array<Any>()
        
        coreDataStore?.fetchEntries(with: predicate, sortDescriptors: sortDescriptors) { (entries) -> Void in
            let todoItemModels = self.parseTodoItems(fromManagedEntries: entries)
            completion(todoItemModels)
        }
    }
    
    
    func parseTodoItems(fromManagedEntries entries: [ManagedTodoItem]) -> [TodoItemModel] {
        var todoItemModels = Array<TodoItemModel>()
        
        for entry in entries {
            let todoItemModel = TodoItemModel(dueDate: entry.date, name: entry.name)
            todoItemModels.append(todoItemModel)
        }
        return todoItemModels
    }
}









