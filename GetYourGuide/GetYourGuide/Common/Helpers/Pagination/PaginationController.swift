//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import UIKit
import PHFDelegateChain

enum PaginationControllerScrollDirection {
  case vertical
  case horizontal
}

enum PaginationControllerHandledLocation {
  case head
  case tail
}

protocol PaginationController: Observer {
  var delegate: PaginationControllerDelegate? { get set }

  var scrollView: UIScrollView? { get set }

  var state: PaginationState { get set }
  var location: PaginationControllerHandledLocation { get set }
  var scrollDirection: PaginationControllerScrollDirection { get set }
}

protocol PaginationControllerDelegate: class {
  func paginationController(_ controller: PaginationController, scrollViewDidScrollOverThreshold: UIScrollView)
}

class PaginationControllerImpl: NSObject, PaginationController {

  // MARK: - Public Variables

  weak var delegate: PaginationControllerDelegate?
  var location: PaginationControllerHandledLocation = .tail
  var scrollDirection: PaginationControllerScrollDirection = .vertical
  weak var scrollView: UIScrollView? {
    didSet {
      self.originalScrollViewDelegate = scrollView?.delegate;
    }
  }

  var state: PaginationState = .tracking {
    didSet {
      guard isObserving else {
        state = .tracking
        return
      }
    }
  }

  // MARK: - Private Variable

  private weak var originalScrollViewDelegate: UIScrollViewDelegate?
  private var delegateChain: PHFDelegateChain!
  private let thresholdProvider: PaginationThresholdProvider
  private var pageRequestIsActive: Bool = false
  private(set) var isObserving: Bool = false

  // MARK: - Observer

  func startObserving() {
    guard !isObserving, let scrollView = scrollView else {
      return
    }

    isObserving = true

    var chain: [UIScrollViewDelegate] = [ self ]
    if let originalScrollViewDelegate = self.originalScrollViewDelegate {
      chain.append(originalScrollViewDelegate)
    }
    self.delegateChain = PHFDelegateChain.init(ofDelegates: chain)
    scrollView.delegate = self.delegateChain as? UIScrollViewDelegate
  }

  func stopObserving() {
    guard isObserving else {
      return
    }

    isObserving = false

    scrollView?.delegate = originalScrollViewDelegate
  }

  // MARK: - Init

  required init(thresholdProvider: PaginationThresholdProvider = PaginationDefaultThresholdProvider()) {
    self.thresholdProvider = thresholdProvider
  }

  deinit {
    stopObserving()
  }
}

extension PaginationControllerImpl: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard isObserving, case .tracking = state else {
      return
    }

    let contentSizeDimension = scrollDirection == .vertical ? scrollView.contentSize.height : scrollView.contentSize.width
    if contentSizeDimension > 0 {
      let scrollViewBoundsSize = scrollView.bounds.size
      let scrollViewSizeDimension = scrollDirection == .vertical ? scrollViewBoundsSize.height : scrollViewBoundsSize.width
      let currentOffsetPosition = scrollDirection == .vertical ? scrollView.contentOffset.y : scrollView.contentOffset.x

      let threshold = thresholdProvider.thresholdInScrollView(scrollView: scrollView,
                                                             scrollDirection: scrollDirection,
                                                             handledLocation: location)
      var thresholdReached = false
      if case .head = location {
        if currentOffsetPosition < threshold {
          thresholdReached = true
        }
      } else {
        if (contentSizeDimension - currentOffsetPosition < threshold + scrollViewSizeDimension) {
          thresholdReached = true
        }
      }

      if thresholdReached {
        delegate?.paginationController(self, scrollViewDidScrollOverThreshold: scrollView)
      }
    }
  }
}
