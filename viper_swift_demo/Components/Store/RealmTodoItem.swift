//
//  RealmTodoItem.swift
//  viper_swift_demo
//
//  Created by PSL on 3/22/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import RealmSwift

//fileprivate let PrimaryKey = "RealmTodoItem"
class RealmTodoItem: Object {
    dynamic var mainKey: NSString?
    dynamic var name: String?
    dynamic var date: NSDate?
    
    
    convenience init(mainKey: String, name: String,date: NSDate) {
        self.init()
        self.mainKey = mainKey as NSString?
        self.name = name
        self.date = date
        print("pri key: \(self.mainKey)")
    }
    
    convenience init(from entry: TodoItem) {
        self.init()
        self.mainKey = entry.primaryKey as NSString?
        self.name = entry.name
        self.date = entry.dueDate as NSDate
    }
    
    /// setting primary key
    /// Declaring a primary key allows objects to be looked up and updated efficiently and enforces uniqueness for each value. Once an object with a primary key is added to a Realm, the primary key cannot be changed.
    override static func primaryKey() -> String? {
        return "mainKey"
    }
}
