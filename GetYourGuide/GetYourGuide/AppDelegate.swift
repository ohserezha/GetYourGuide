//
//  AppDelegate.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 8/9/19.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

import UIKit
import Swinject


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let resolver = AppAssembler.current.resolver
        let factory = resolver.resolve(ReviewsListModuleFactory.self)!
        let module = factory.createModule()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = module.view
        window?.makeKeyAndVisible()

        return true
    }
}
