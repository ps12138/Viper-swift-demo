//
//  ListWireframe.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import UIKit


fileprivate let ListViewControllerId = "ListViewController"
fileprivate let MainStoryboardId = "main"

class ListWireframe {
    
    // MARK: - properties
    var addWireframe: AddWireframe?
    var listPresenter: ListPresenter?
    var rootWireframe: RootWireframe?
    var listViewController: ListViewController?
    
    // MARK: - func
    
    ///
    func present(listInterfaceTo window: UIWindow) {
        if let viewController = instantiate(listViewController: ListViewControllerId, from: MainStoryboardId) {
            
            viewController.eventHandler = listPresenter
            listViewController = viewController
            listPresenter?.userInterface = viewController
            rootWireframe?.setRootViewController(viewController, inWindow: window)
        }
    }
    
    ///
    func presentAddInterface() {
        addWireframe?.presentAddInterfaceFromViewCOntroller(listViewController)
    }
    
    // MARK: - private methods
    private func instantiate(listViewController viewControllerId: String, from storyboardId: String) -> ListViewController? {
        
        let storyboard = fetch(storyboard: storyboardId)
        if let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId) as? ListViewController {
            return viewController
        }
        return nil
    }
    
    
    private func fetch(storyboard name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
    
    
}
