//
//  AddInteractor.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation



class AddInteractor {
    var addDataManager: AddDataManager?
    
    func save(newEntry name: String, dueDate: Date) {
        let newEntry = TodoItemModel(dueDate: dueDate, name: name)
        addDataManager?.addNewEntry(newEntry)
    }
    
    
}
