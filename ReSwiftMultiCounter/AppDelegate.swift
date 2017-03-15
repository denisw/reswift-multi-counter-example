//
//  AppDelegate.swift
//  ReSwiftMultiCounter
//
//  Created by Denis Washington on 13/03/2017.
//  Copyright © 2017 Denis Washington. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let rootViewController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }

}

