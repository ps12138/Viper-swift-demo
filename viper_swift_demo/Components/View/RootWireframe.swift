//
//  RootWireframe.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe {
    func setRootViewController(_ viewController: UIViewController, inWindow window: UIWindow) {
        if let navigationController = navigationController(from: window) {
            navigationController.viewControllers = [viewController]
        } else {
            window.rootViewController = viewController
        }
    }
    
    private func navigationController(from window: UIWindow) -> UINavigationController? {
        let navigationController = window.rootViewController as? UINavigationController
        return navigationController
    }
}

