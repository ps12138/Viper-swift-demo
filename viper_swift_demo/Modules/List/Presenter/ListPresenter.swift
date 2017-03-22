//
//  ListPresenter.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


class ListPresenter {
    
    // MARK: - properties
    var listInteractor: ListInteractorInputDelegate?
    var listWireframe: ListWireframe?
    var userInterface: ListViewInterface?
    
    func updateUserInterfaceWithUpcomingItems(upcomingItems: [UpcomingItem]) {
        let upcomingDisplayData = upcomingDisplayDataWithItems(upcomingItems)
        userInterface?.show(upcomingDispalyData: upcomingDisplayData)
    }
    
    func upcomingDisplayDataWithItems(_ upcomingItems: [UpcomingItem]) -> UpcomingDisplayData {
        let collection = UpcomingDisplayDataCollection()
        collection.addUpcomingItems(upcomingItems)
        return collection.collectedDisplayData()
    }
    
}



extension ListPresenter {
    
    
}

// MARK: - ListInteractorOutputDelegate
extension ListPresenter: ListInteractorOutputDelegate {
    /// 
    func foundUpcomingItems(upcomingItems: [UpcomingItem]) {
        if upcomingItems.isEmpty {
            userInterface?.show(noContentMessage: "Sorry, We cannot find content")
        } else {
            
        }
    }
}

// MARK: - interface ListModuleInterface
extension ListPresenter: ListModuleInterface {
    func addNewEntry() {
        listWireframe?.presentAddInterface()
    }
    
    func updateView() {
        listInteractor?.findUpcomingItems()
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







