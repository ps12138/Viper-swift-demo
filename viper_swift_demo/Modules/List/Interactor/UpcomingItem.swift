//
//  UpcomingItem.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


struct UpcomingItem: Equatable {
    let title: String
    let dueDate: Date
    let dateRelation: NearTermDateRelation
    
    init(title: String,
         dueDate: Date = Date(),
         dateRelation: NearTermDateRelation = .OutOfRange) {
        
        self.title = title
        self.dueDate = dueDate
        self.dateRelation = dateRelation
    }
    
    static func ==(left: UpcomingItem, right: UpcomingItem) -> Bool {
        var hasEqualSection = left.title == right.title
        
        if hasEqualSection == false {
            return false
        }
        
        hasEqualSection = left.dueDate == right.dueDate
        if hasEqualSection == false {
            return false
        }
        
        hasEqualSection = left.dateRelation == right.dateRelation
        return hasEqualSection
    }
    
}


