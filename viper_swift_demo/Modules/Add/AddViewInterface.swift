//
//  AddViewInterface.swift
//  viper_swift_demo
//
//  Created by PSL on 3/23/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


protocol AddViewToPresenterDelegate: class {
    func cancelAddAction()
    func saveAddAction(name: String, dueDate: Date)
}

protocol PresenterToAddViewDelegate: class {
    func setEntry(name: String)
    func setEntry(dueDate date: Date)
    func set(minDueDate date: Date)
}
