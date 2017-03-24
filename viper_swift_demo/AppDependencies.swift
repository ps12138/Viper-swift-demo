//
//  AppDependencies.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    var listWireframe = ListWireframe()
    
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        let navigationCtroller = UINavigationController()
        window.rootViewController = navigationCtroller
        window.makeKeyAndVisible()
        listWireframe.present(listInterfaceTo: window)
        
    }
    
    func configureDependencies() {
        let dataStore = RealmStore()
        let clock = DeviceClock()
        let rootWireframe = RootWireframe()
        
        let listPresenter = ListPresenter()
        let listDataManager = ListDataManager()
        let listInteractor = ListInteractor(dataManager: listDataManager, clock: clock)
        
        let addWireframe = AddWireframe()
        let addInteractor = AddInteractor()
        let addPresenter = AddPresenter()
        let addDataManager = AddDataManager()
        
        listInteractor.output = listPresenter
        
        listPresenter.listInteractor = listInteractor
        listPresenter.listWireframe = listWireframe
        
        listWireframe.addWireframe = addWireframe
        listWireframe.listPresenter = listPresenter
        listWireframe.rootWireframe = rootWireframe
        
        listDataManager.dataStore = dataStore
        
        addInteractor.addDataManager = addDataManager
        
        addWireframe.addPresenter = addPresenter
        
        addPresenter.addWireframe = addWireframe
        addPresenter.addModuleDelegate = listPresenter
        addPresenter.addInteractor = addInteractor
        
        addDataManager.dataStore = dataStore
    }
}
