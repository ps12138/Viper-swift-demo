//
//  UpcomingDispalyData.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


class UpcomingDisplayData {
    var sections = Array<UpcomingDisplaySection>()
    
    init(sections: [UpcomingDisplaySection]) {
        self.sections = sections
    }
}

/// MARK: - getting count
extension UpcomingDisplayData {
    
    var count: Int {
        return self.sections.count
    }
    var isEmpty: Bool {
        return self.sections.isEmpty
    }
    var isConentEmpty: Bool {
        for section in self.sections {
            if section.isEmpty == false {
                return false
            }
        }
        return true
    }
    
    func count(ofSection section: Int) -> Int? {
        if section < 0 || section >= self.count {
            return nil
        }
        return sections[section].count
    }
    
    func isEmpty(ofSection section: Int) -> Bool {
        if section < 0 || section >= self.count {
            return true
        }
        return sections[section].isEmpty
    }
}


/// MARK: - operate cell data
extension UpcomingDisplayData {
    func fetch(item indexPath: IndexPath) -> UpcomingDisplayItem? {
        if indexPath.section < 0 || indexPath.row < 0 {
            return nil
        }
        
        if indexPath.section >= self.sections.count {
            return nil
        }
        let section = self.sections[indexPath.section]
        if indexPath.row >= section.count {
            return nil
        }
        return section.items[indexPath.row]
    }
    
    func remove(item indexPath: IndexPath) -> UpcomingDisplayItem? {
        if indexPath.section < 0 || indexPath.row < 0 {
            return nil
        }
        if indexPath.section >= self.sections.count {
            return nil
        }
        let section = self.sections[indexPath.section]
        if indexPath.row >= section.count {
            return nil
        }
        let removed = section.items[indexPath.row]
        self.sections[indexPath.section].items.remove(at: indexPath.row)
        return removed
    }
}

// MARK: - operate section title
extension UpcomingDisplayData {
    func fetch(sectionTitle section: Int) -> String? {
        if section >= 0, section < sections.count,
            self.sections[section].count > 0 {
            return self.sections[section].name
        }
        return nil
    }
}

extension UpcomingDisplayData: Equatable {
    static func ==(lhs: UpcomingDisplayData, rhs: UpcomingDisplayData) -> Bool {
        return lhs.sections == rhs.sections
    }
}


