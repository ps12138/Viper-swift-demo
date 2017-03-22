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
    let dayFormatter = DateFormatter()
    var sections = Dictionary<NearTermDateRelation, [UpcomingDisplayItem]>()
    
    init() {
        dayFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEE", options: 0, locale: Locale.autoupdatingCurrent)
    }
    
    func addUpcomingItems(_ upcomingItems: [UpcomingItem]) {
        for upcomingItem in upcomingItems {
            addUpcomingItem(upcomingItem)
        }
    }
    
    func addUpcomingItem(_ upcomingItem: UpcomingItem) {
        let displayItem = displayItemForUpcomingItem(upcomingItem)
        addDisplayItem(displayItem, dateRelation: upcomingItem.dateRelation)
    }
    
    func addDisplayItem(_ displayItem: UpcomingDisplayItem, dateRelation: NearTermDateRelation) {
        if var realSection: [UpcomingDisplayItem] = sections[dateRelation] {
            realSection.append(displayItem)
            sections[dateRelation] = realSection
        } else {
            var newSection = Array<UpcomingDisplayItem>()
            newSection.append(displayItem)
            sections[dateRelation] = newSection
        }
    }
    
    func displayItemForUpcomingItem(_ upcomingItem: UpcomingItem) -> UpcomingDisplayItem {
        let day = formattedDay(upcomingItem.dueDate, dateRelation: upcomingItem.dateRelation)
        let displayItem = UpcomingDisplayItem(title: upcomingItem.title, dueDate: day)
        return displayItem
    }
    
    func formattedDay(_ date: Date, dateRelation: NearTermDateRelation) -> String {
        if dateRelation == NearTermDateRelation.Today {
            return ""
        }
        
        return dayFormatter.string(from: date)
    }
    
    func collectedDisplayData() -> UpcomingDisplayData {
        let collectedSections: [UpcomingDisplaySection] = sortedUpcomingDisplaySections()
        return UpcomingDisplayData(sections: collectedSections)
    }
    
    func displaySectionForDateRelation(_ dateRelation: NearTermDateRelation) -> UpcomingDisplaySection {
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
    
    func sortedNearTermDateRelations() -> [NearTermDateRelation] {
        var array = Array<NearTermDateRelation>()
        array.insert(.Today, at: 0)
        array.insert(.Tomorrow, at: 1)
        array.insert(.LaterThisWeek, at: 2)
        array.insert(.NextWeek, at: 3)
        return array
    }
    
    func sectionTitleForDateRelation(_ dateRelation: NearTermDateRelation) -> String {
        switch dateRelation {
        case .Today:
            return "Today"
        case .Tomorrow:
            return "Tomorrow"
        case .LaterThisWeek:
            return "Later This Week"
        case .NextWeek:
            return "Next Week"
        case .OutOfRange:
            return "Unknown"
        }
    }
    
    func sectionImageNameForDateRelation(_ dateRelation: NearTermDateRelation) -> String {
        switch dateRelation {
        case .Today:
            return "check"
        case .Tomorrow:
            return "alarm"
        case .LaterThisWeek:
            return "circle"
        case .NextWeek:
            return "calendar"
        case .OutOfRange:
            return "paper"
        }
    }
}
