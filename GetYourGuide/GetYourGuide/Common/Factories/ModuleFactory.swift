//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import UIKit
import SwinjectStoryboard

struct Module<T> {
    let moduleInput: T
    let view: UIViewController
}

protocol ModuleFactory {
    associatedtype ModuleInput

    func createModule() -> Module<ModuleInput>
}

extension ModuleFactory {
    func make<T: UIViewController>(_: T.Type) -> T {
        return SwinjectStoryboard.instantiateViewController(T.self)
    }
}

