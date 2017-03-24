//
//  UpcomingDisplaySection.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


struct UpcomingDisplaySection {
    let name: String
    let imageName: String
    var items = Array<UpcomingDisplayItem>()
    
    init(name: String, imageName: String, items: [UpcomingDisplayItem]?) {
        self.name = name
        self.imageName = imageName
        
        if let items = items {
            self.items = items
        }
    }
}

extension UpcomingDisplaySection {
    var count: Int {
        return self.items.count
    }
    var isEmpty: Bool {
        return self.items.isEmpty
    }
}

extension UpcomingDisplaySection: Equatable {
    static func ==(left: UpcomingDisplaySection, right: UpcomingDisplaySection) -> Bool {
        return left.items == right.items
    }
}
