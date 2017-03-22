//
//  UpcomingDispalyData.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


struct UpcomingDisplayData {
    var sections = Array<UpcomingDisplaySection>()
    
    init(sections: [UpcomingDisplaySection]) {
        self.sections = sections
    }
}


extension UpcomingDisplayData: Equatable {
    static func ==(lhs: UpcomingDisplayData, rhs: UpcomingDisplayData) -> Bool {
        return lhs.sections == rhs.sections
    }
}
