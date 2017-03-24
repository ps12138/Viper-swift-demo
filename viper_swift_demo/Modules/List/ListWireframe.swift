//
//  ListWireframe.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import UIKit


class ListWireframe {
    
    // MARK: - properties connencting
    weak var listViewController: ListViewController?
    
    
    
    // MARK: - properties owned
    var rootWireframe: RootWireframe?
    var listPresenter: ListPresenter?
    var addWireframe: AddWireframe?
    
    // MARK: - internal methods
    func present(listInterfaceTo window: UIWindow) {
        let viewController = instantiateListViewController()
        viewController.eventHandler = listPresenter
        listViewController = viewController
        listPresenter?.viewController = viewController
        rootWireframe?.setRootViewController(viewController, inWindow: window)
    }
    
    func presentAddInterface() {
        if let listViewController = listViewController {
            addWireframe?.presentAddInterfaceFromViewController(viewController: listViewController)
        }
    }
    
    // MARK: - private methods
    private func instantiateListViewController() -> ListViewController {
        if let listViewController = self.listViewController {
            return listViewController
        }
        return ListViewController(title: "ListViewController")
    }
}
