//
//  UpcomingDisplayItem.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


struct UpcomingDisplayItem {
    let title: String = ""
    let dueDate: String = ""

    init(title: String, dueDate: String) {
        self.title = title
        self.dueDate = dueDate
    }
}


extension UpcomingDisplayItem: Equatable {
    static func ==(left: UpcomingDisplayItem, right: UpcomingDisplayItem) -> Bool {
        let hasEqualSections = left.title == right.title
        if hasEqualSections == false {
            return false
        }
        return left.dueDate == right.dueDate
    }
}


extension UpcomingDisplayItem {
    var description: String {
        return "\(title) -- \(dueDate)"
    }
}
