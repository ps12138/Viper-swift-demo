//
//  AddDataManager.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


class AddDataManager {
    var dataStore: RealmStore?
    
    func addNewEntry(_ entry: TodoItem) {
        self.dataStore?.save(entry)
    }
}
