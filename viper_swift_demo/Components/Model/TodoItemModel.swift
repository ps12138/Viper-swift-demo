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
enum NearTermDateRelation {
    
    case Today
    case Tomorrow
    case LaterThisWeek
    case NextWeek
    case OutOfRange
}


/// model of TodoItem
struct TodoItemModel {
    let dueDate: Date
    let name: String
    
    init(dueDate: Date, name: String) {
        self.dueDate = dueDate
        self.name = name
    }
}
