//
//  Clock.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation



/// Clock protocol/interface
protocol Clock: class {
    func today() -> Date
}

// fetch current date
class DeviceClock: Clock {
    func today() -> Date {
        return Date()
    }
}

