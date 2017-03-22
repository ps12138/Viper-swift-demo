//
//  ManagedTodoOtem.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import CoreData


class ManagedTodoItem: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var date: Date
}
