//
//  ListInteractor.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


protocol ListInteractorInputDelegate: class {
    func findUpcomingItems()
}

protocol ListInteractorOutputDelegate: class {
    func foundUpcomingItems(upcomingItems: [UpcomingItem])
}


class ListInteractor: ListInteractorInputDelegate{
    var output: ListInteractorOutputDelegate?
    
    let clock: Clock
    let dataManager: ListDataManager
    
    init(dataManager: ListDataManager, clock: Clock) {
        self.dataManager = dataManager
        self.clock = clock
    }
    
    func findUpcomingItems() {
        let today = clock.today()
        let endOfNextWeek = Calendar.current.date(endOfWeekWithDate: today)
        
        dataManager.todoItems(between: today, and: endOfNextWeek) {
            (todoItemModels) in
            let upcomingItem = self.upcomingItems(from: todoItemModels)
            self.output?.foundUpcomingItems(upcomingItems: upcomingItem)
        }
        
    }
    
    
    func upcomingItems(from todoItems: [TodoItemModel]) -> [UpcomingItem] {
        let calendar = Calendar.autoupdatingCurrent
        
        var upcomingItems = Array<UpcomingItem>()
        
        for todoItem in todoItems {
            let dateRelation = calendar.date(relationfrom: todoItem.dueDate, relativeTo: clock.today())
            let upcomingItem = UpcomingItem(title: todoItem.name, dueDate: todoItem.dueDate, dateRelation: dateRelation)
            upcomingItems.append(upcomingItem)
        }
        return upcomingItems
    }
    
    
}












