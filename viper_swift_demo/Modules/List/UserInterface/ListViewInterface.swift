//
//  ListViewInterface.swift
//  viper_swift_demo
//
//  Created by PSL on 3/23/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


/// ListView Interface API, implemented by ListViewController
/// Presenter tell ListViewController to do
protocol ListViewInterface: class {
    func show(noContentMessage title: String)
    func show(upcomingDispalyData data: UpcomingDisplayData)
    func reloadEntries()
}

/// ListView Delegate API, implemented by Presenter
/// ListViewController let Presenter know how to update
protocol ListViewDelegate: class {
    func addNewEntry()
    func updateView()
    func removeEntry(_ entry: UpcomingDisplayItem) -> Bool
}
