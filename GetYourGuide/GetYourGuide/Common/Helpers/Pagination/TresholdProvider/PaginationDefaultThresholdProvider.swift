//
// Created by Nickolay Sheika on 6/20/18.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import UIKit

class PaginationDefaultThresholdProvider: PaginationThresholdProvider {

  func thresholdInScrollView(scrollView: UIScrollView,
                             scrollDirection: PaginationControllerScrollDirection,
                             handledLocation: PaginationControllerHandledLocation) -> CGFloat {
    if handledLocation == .head {
      return scrollDirection == .vertical ? scrollView.contentInset.top : scrollView.contentInset.left
    }

    var contentSizeDimension: CGFloat = 0
    switch scrollDirection {
      case .vertical:
        contentSizeDimension = scrollView.bounds.height
      case .horizontal:
        contentSizeDimension = scrollView.bounds.width
    }
    let threshold = contentSizeDimension * 0.1
    return threshold
  }
}
