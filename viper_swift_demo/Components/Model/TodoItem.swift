//
//  TodoItem.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


/// Time range for date
///
/// - OutOfRange: beyond next week
/// - Today: within Today
/// - Tomorrow: at Tomorrow
/// - LaterThisWeek: rest of this week, beyond tomorrow
/// - NextWeek: in NextWeek
enum DateRelation {
    
    case Today
    case Tomorrow
    case LaterThisWeek
    case NextWeek
    case LaterThisMonth
    case OutOfRange
}


/// model of TodoItem
struct TodoItem {
    var primaryKey: String
    var dueDate: Date
    var name: String
    
    init(dueDate: Date, name: String) {
        self.primaryKey = Date().description
        self.dueDate = dueDate
        self.name = name
    }
    
    init(from entry: RealmTodoItem) {
        self.primaryKey = (entry.mainKey ?? "") as String
        self.dueDate = entry.date as Date? ?? Date()
        self.name = entry.name ?? ""
    }
}


extension TodoItem: Equatable {
    static func ==(left: TodoItem, right: TodoItem) -> Bool {
        return left.primaryKey == right.primaryKey
    }
}


