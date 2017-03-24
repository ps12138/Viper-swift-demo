//
//  AddPresenter.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation

class AddPresenter {
    
    // MARK: - Properties owned
    var addInteractor : AddInteractor?
    
    // MARK: - Properties connecting
    weak var addWireframe : AddWireframe?
    
    // MARK: - Delegate
    weak var addModuleDelegate : AddModuleDelegate?
    
    
    func configureAddView(_ toAddView: PresenterToAddViewDelegate) {
        toAddView.set(minDueDate: Date())
    }
}

// MARK: - AddViewToPresenterDelegate
extension AddPresenter: AddViewToPresenterDelegate {
    
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
