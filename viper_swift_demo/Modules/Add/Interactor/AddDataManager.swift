//
//  AddDataManager.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


class AddDataManager {
    var dataStore: CoreDataStore?
    
    func addNewEntry(_ entry: TodoItemModel) {
        if let newEntry = self.dataStore?.newTodoItem() {
            newEntry.name = entry.name
            newEntry.date = entry.dueDate
            self.dataStore?.save()
        }
    }
}
