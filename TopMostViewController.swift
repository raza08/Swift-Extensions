//
//  TopMostViewController.swift
//
//  Created by Augus on 9/26/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit

/**
 Description: the toppest view controller of presenting view controller
 How to use: UIApplication.topMostViewController
 Where to use: controllers are not complex
 */

extension UIApplication {
    
    var topMostViewController: UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }

    var topMostNavigationController: UINavigationController? {
        return topMostViewController as? UINavigationController
    }

    /// App has more than one window and just want to get topMostViewController of the AppDelegate window.
    var appDelegateWindowTopMostViewController: UIViewController? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        var topController = delegate?.window?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
}


/**
 Description: the toppest view controller of presenting view controller
 How to use:  UIApplication.sharedApplication().keyWindow?.rootViewController?.topMostViewController
 Where to use: There are lots of kinds of controllers (UINavigationControllers, UITabbarControllers, UIViewController)
 */

extension UIViewController {
    var topMostViewController: UIViewController? {
        // Handling Modal views
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController
        }
            // Handling UIViewController's added as subviews to some other views.
        else {
            for view in self.view.subviews
            {
                // Key property which most of us are unaware of / rarely use.
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as! UIViewController
                        return viewController.topMostViewController
                    }
                }
            }
            return self
        }
    }
}

extension UITabBarController {

    override var topMostViewController: UIViewController? {
        return self.selectedViewController?.topMostViewController
    }

    var topVisibleViewController: UIViewController? {
        var top = selectedViewController
        while top?.presentedViewController != nil {
            top = top?.presentedViewController
        }
        return top
    }
}

extension UINavigationController {
    override var topMostViewController: UIViewController? {
        return self.visibleViewController?.topMostViewController
    }
}
