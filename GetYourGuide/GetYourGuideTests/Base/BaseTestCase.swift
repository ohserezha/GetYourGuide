//
// Created by Nickolay Sheika on 2019-08-11.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import XCTest
import Swinject
@testable import GetYourGuide

class BaseTestCase: XCTestCase {
    let assembler: Assembler = {
        Assembler(assemblies())
    }()

    private class func assemblies() -> [Assembly] {
        return [
            TestableReviewsListAssembly()
        ]
    }
}
