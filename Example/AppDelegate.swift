//
//  AppDelegate.swift
//  FocusZPositionMutating
//
//  Created by Toshihiro Suzuki on 2017/11/13.
//  Copyright © 2017 toshi0383. All rights reserved.
//

import FocusZPositionMutating
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        try! UIView.fzpm_swizzleDidUpdateFocus(focusedZPosition: 0.0, unfocusedZPosition: -0.2)
        fzpm_isDebugEnabled = true

        return true
    }
}
