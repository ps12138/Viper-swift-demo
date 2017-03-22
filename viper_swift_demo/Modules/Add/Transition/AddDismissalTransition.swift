//
//  AddDismissalTransition.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import UIKit

class AddDismissalTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.72
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! AddViewController
        
        //let finalCenter = CGPointMake(160.0, (fromVC.view.bounds.size.height / 2) - 1000.0)
        let finalCenter = CGPoint(x: 160.0, y: fromVC.view.bounds.size.height / 2 - 1000.0)
        
        let options = UIViewAnimationOptions.curveEaseIn
        
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0.0,
            usingSpringWithDamping: 0.64,
            initialSpringVelocity: 0.22,
            options: options,
            animations: {
                fromVC.view.center = finalCenter
                fromVC.transitioningBackgroundView.alpha = 0.0
            },
            completion: { finished in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        )
    }
    
}
