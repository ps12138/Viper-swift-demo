//
//  AddPresenter.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation

class AddPresenter {
    var addInteractor : AddInteractor?
    var addWireframe : AddWireframe?
    var addModuleDelegate : AddModuleDelegate?
    
    
    func configureUserInterfaceForPresentation(_ addViewUserInterface: AddViewInterface) {
        addViewUserInterface.set(minDueDate: Date())
    }
}

extension AddPresenter: AddModuleInterface {
    
    func cancelAddAction() {
        addWireframe?.dismissAddInterface()
        addModuleDelegate?.addModuleDidCancelAddAction()
    }
    
    func saveAddAction(name: String, dueDate: Date) {
        addInteractor?.save(newEntry: name, dueDate: dueDate)
        addWireframe?.dismissAddInterface()
        addModuleDelegate?.addModuleDidSaveAddAction()
    }

}
