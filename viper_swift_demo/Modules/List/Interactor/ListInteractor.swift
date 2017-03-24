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
    func findNewItems()
    func findOldItems()
    func removeItem(by primarykey: String) -> Bool
}

protocol ListInteractorOutputDelegate: class {
    func foundUpcomingItems(items: [TodoItem])
}


class ListInteractor: ListInteractorInputDelegate{
    
    // MARK: - delegate
    var output: ListInteractorOutputDelegate?
    
    // MARK: - properties owned
    let clock: Clock
    let dataManager: ListDataManager
    
    // MARK: - init
    init(dataManager: ListDataManager, clock: Clock) {
        self.dataManager = dataManager
        self.clock = clock
    }
    
    // MARK: - methods
    func findUpcomingItems() {
        let today = clock.today()
        let endOfNextWeek = Calendar.current.date(endOfFollowingWeekFrom: today)
        dataManager.todoItems(between: today, and: endOfNextWeek) {
            (todoItems) in
            self.output?.foundUpcomingItems(items: todoItems)
        }
    }
    
    func findNewItems() {
        let today = clock.today()
        dataManager.todoItems(from: today) {
            (todoItems) in
            self.output?.foundUpcomingItems(items: todoItems)
        }
    }

    func findOldItems() {
        let today = clock.today()
        dataManager.todoItems(before: today) {
            (todoItems) in
            self.output?.foundUpcomingItems(items: todoItems)
        }
    }
    
    func removeItem(by primarykey: String) -> Bool {
        return dataManager.removeItem(by: primarykey)
    }
    
    
}












