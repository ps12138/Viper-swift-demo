//
//  AddWireFrame.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import UIKit


class AddWireframe: NSObject {
    
    var addPresenter : AddPresenter?
    weak var presentedViewController : UIViewController?
    
    func presentAddInterfaceFromViewController(viewController: UIViewController) {
        let newViewController = instantiateAddViewController()
        newViewController.eventHandler = addPresenter
        newViewController.modalPresentationStyle = .custom
        newViewController.transitioningDelegate = self
        addPresenter?.configureAddView(newViewController)
        viewController.present(newViewController, animated: true, completion: nil)
        presentedViewController = newViewController
    }
    
    func dismissAddInterface() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func instantiateAddViewController() -> AddViewController {
        return AddViewController(title: "AddViewController")
    }
}



// MARK: - UIViewControllerTransitioningDelegate
extension AddWireframe: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AddPresentationTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AddDismissalTransition()
    }
}






