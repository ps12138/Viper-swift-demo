//
//  AddModuleInterface.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation

protocol AddModuleInterface: class {
    func cancelAddAction()
    func saveAddAction(name: String, dueDate: Date)
}
