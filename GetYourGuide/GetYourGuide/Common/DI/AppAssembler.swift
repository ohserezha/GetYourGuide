//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import Swinject

final class AppAssembler {
    static let current: Assembler = {
        Assembler(assemblies())
    }()

    private class func assemblies() -> [Assembly] {
        return [
            ReviewsListAssembly()
        ]
    }
}
