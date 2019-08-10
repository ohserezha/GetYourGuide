//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import UIKit

protocol PaginationThresholdProvider {
  func thresholdInScrollView(scrollView: UIScrollView,
                             scrollDirection: PaginationControllerScrollDirection,
                             handledLocation: PaginationControllerHandledLocation) -> CGFloat
}