//
//  UpcomingDisplayDataCollection.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


import Foundation

class UpcomingDisplayDataCollection {
    
    let clock: Clock
    let dayFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    var sections = Dictionary<DateRelation, [UpcomingDisplayItem]>()
    
    init(clock: Clock) {
        
        self.clock = clock
        self.dayFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEE", options: 0, locale: Locale.autoupdatingCurrent)
        self.dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dd-MMM-yyyy HH:mm.ss", options: 0, locale: Locale.autoupdatingCurrent)
    }
    
    
    /// process TodoItem array to DispalyData Set
    ///
    /// - Parameter items: [TodoItem]
    func addUpcomingItems(_ items: [TodoItem]) {
        for item in items {
            self.addUpcomingItem(item)
        }
    }

    /// process single TodoItem to DispalyData Set
    ///
    /// - Parameter item: TodoItem
    func addUpcomingItem(_ todoItem: TodoItem) {
        let aDisplayItem = displayItem(from: todoItem)
        addDisplayItem(aDisplayItem, dateRelation: aDisplayItem.dateRelation)
    }
    
    func addDisplayItem(_ displayItem: UpcomingDisplayItem, dateRelation: DateRelation) {
        
        if var realSection: [UpcomingDisplayItem] = sections[dateRelation] {
            realSection.append(displayItem)
            sections[dateRelation] = realSection
        } else {
            var newSection = Array<UpcomingDisplayItem>()
            newSection.append(displayItem)
            sections[dateRelation] = newSection
        }
    }
    
    
    func displayItem(from todoItem: TodoItem) -> UpcomingDisplayItem {
        let calendar = Calendar.autoupdatingCurrent
        let dateRelation = calendar.date(relationfrom: todoItem.dueDate, relativeTo: self.clock.today())
        
        let dueWeekday = formattedDay(todoItem.dueDate, dateRelation: dateRelation)
        let dueDate = dateFormatter.string(from: todoItem.dueDate)
        
        let displayItem = UpcomingDisplayItem(
                primaryKey: todoItem.primaryKey,
                title: todoItem.name,
                dueWeekday: dueWeekday,
                dueDate: dueDate,
                dateRelation: dateRelation
            )
        return displayItem
    }
    
    
    func formattedDay(_ date: Date, dateRelation: DateRelation) -> String {
        if dateRelation == DateRelation.Today {
            return "Today"
        }
        return dayFormatter.string(from: date)
    }
    
    func collectedDisplayData() -> UpcomingDisplayData {
        let collectedSections: [UpcomingDisplaySection] = sortedUpcomingDisplaySections()
        return UpcomingDisplayData(sections: collectedSections)
    }
    
    func displaySectionForDateRelation(_ dateRelation: DateRelation) -> UpcomingDisplaySection {
        let sectionTitle = sectionTitleForDateRelation(dateRelation)
        let imageName = sectionImageNameForDateRelation(dateRelation)
        let items = sections[dateRelation]
        
        return UpcomingDisplaySection(name: sectionTitle, imageName: imageName, items: items)
    }
    
    func sortedUpcomingDisplaySections() -> [UpcomingDisplaySection] {
        let keys = sortedNearTermDateRelations()
        var displaySections = Array<UpcomingDisplaySection>()
        
        for dateRelation in keys {
            if let _ = sections[dateRelation] {
                let displaySection = displaySectionForDateRelation(dateRelation)
                displaySections.insert(displaySection, at: displaySections.endIndex)
            }
        }
        
        return displaySections
    }
    
    func sortedNearTermDateRelations() -> [DateRelation] {
        var array = Array<DateRelation>()
        array.append(.Today)
        array.append(.Tomorrow)
        array.append(.LaterThisWeek)
        array.append(.NextWeek)
        array.append(.LaterThisMonth)
        array.append(.OutOfRange)
        return array
    }
    
    func sectionTitleForDateRelation(_ dateRelation: DateRelation) -> String {
        switch dateRelation {
        case .Today:
            return "Today"
        case .Tomorrow:
            return "Tomorrow"
        case .LaterThisWeek:
            return "Later in this Week"
        case .NextWeek:
            return "Next Week"
        case .LaterThisMonth:
            return "Later in this Month"
        case .OutOfRange:
            return "Beyond this Month"
        }
    }
    
    func sectionImageNameForDateRelation(_ dateRelation: DateRelation) -> String {
        switch dateRelation {
        case .Today:
            return "check"
        case .Tomorrow:
            return "alarm"
        case .LaterThisWeek:
            return "circle"
        case .NextWeek:
            return "calendar"
        case .LaterThisMonth:
            return "calendar"
        case .OutOfRange:
            return "paper"
        }
    }
}
