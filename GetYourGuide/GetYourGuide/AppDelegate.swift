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

        module.moduleInput.setupWith(tour: tourModel())

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = module.view
        window?.makeKeyAndVisible()

        return true
    }
}

extension AppDelegate {
    func tourModel() -> TourModel {
        let city = CityModel(remoteID: "berlin-l17")
        return TourModel(remoteID: "tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776", city: city)
    }
}
