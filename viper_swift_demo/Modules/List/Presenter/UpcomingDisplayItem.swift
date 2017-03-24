//
//  UpcomingDisplayItem.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


struct UpcomingDisplayItem {
    
    var primaryKey: String
    var title: String
    var dueWeekday: String
    var dueDate: String
    var dateRelation: DateRelation
    

    init(primaryKey: String, title: String, dueWeekday: String, dueDate: String, dateRelation: DateRelation) {
        self.primaryKey = primaryKey
        self.title = title
        self.dueWeekday = dueWeekday
        self.dueDate = dueDate
        self.dateRelation = dateRelation
    }
}

extension UpcomingDisplayItem: Equatable {
    static func ==(left: UpcomingDisplayItem, right: UpcomingDisplayItem) -> Bool {
        return left.primaryKey == right.primaryKey
    }
}

extension UpcomingDisplayItem {
    var description: String {
        return "PrimaryKey \(primaryKey) -- \(title) -- \(dueWeekday) -- \(dueDate))"
    }
}
