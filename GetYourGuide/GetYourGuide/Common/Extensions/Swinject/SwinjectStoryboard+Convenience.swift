//
//  SwinjectStoryboard+Convenience.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 8/9/19.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func create(name: String) -> SwinjectStoryboard {
        let resolver = AppAssembler.current.resolver
        return SwinjectStoryboard.create(name: name, bundle: nil, container: resolver)
    }

    class func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
        let identifier = String(describing: type(of: T.self)).components(separatedBy: ".").first!
        let storyboard = SwinjectStoryboard.create(name: identifier)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        return controller
    }
}
