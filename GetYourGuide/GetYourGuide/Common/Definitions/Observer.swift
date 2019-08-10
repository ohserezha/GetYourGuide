//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

protocol Observer {
  var isObserving: Bool { get }

  func startObserving()
  func stopObserving()
}