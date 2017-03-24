//
//  ListPresenter.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


class ListPresenter {

    // MARK: - properties connencting
    weak var listWireframe: ListWireframe?
    
    // MARK: - properties owned
    
    var listInteractor: ListInteractorInputDelegate?
    
    // MARK: - delegate
    weak var viewController: ListViewInterface?
    
    func updateViewController(with items: [TodoItem]) {
        let viewModel = upcomingDisplayDataSet(with: items)
        viewController?.show(upcomingDispalyData: viewModel)
    }
    
    func upcomingDisplayDataSet(with items: [TodoItem]) -> UpcomingDisplayData {
        let collection = UpcomingDisplayDataCollection(clock: DeviceClock())
        collection.addUpcomingItems(items)
        return collection.collectedDisplayData()
    }
    
}

// MARK: - ListInteractorOutputDelegate
extension ListPresenter: ListInteractorOutputDelegate {
    /// 
    func foundUpcomingItems(items: [TodoItem]) {
        if items.isEmpty {
            self.viewController?.show(noContentMessage: "Sorry, We cannot find content")
        } else {
            self.updateViewController(with: items)
        }
    }
}

// MARK: - ListViewDelegate
extension ListPresenter: ListViewDelegate {
    func addNewEntry() {
        listWireframe?.presentAddInterface()
    }
    
    func updateView() {
        listInteractor?.findNewItems()
    }
    
    func removeEntry(_ entry: UpcomingDisplayItem) -> Bool {
        let primaryKey = entry.primaryKey
        if let res = self.listInteractor?.removeItem(by: primaryKey) {
            return res
        }
        return false
    }
}

//MARK: - Delegation AddModuleDelegate
extension ListPresenter: AddModuleDelegate {
    
    func addModuleDidCancelAddAction() {
        
    }
    func addModuleDidSaveAddAction() {
        self.updateView()
    }
}
