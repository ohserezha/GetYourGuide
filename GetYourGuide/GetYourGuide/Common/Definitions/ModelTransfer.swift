//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

protocol ModelTransfer {
    associatedtype ModelType

    func update(with model: ModelType)
    func appendItems(with model: ModelType) // optional
}

extension ModelTransfer {
    func appendItems(with model: ModelType) {
    }
}