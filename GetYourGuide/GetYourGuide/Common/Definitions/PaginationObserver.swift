//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

protocol PaginationObserver {
  var paginationFacade: PaginationFacade! { get set }

  func startPaginationObserving()
  func stopPaginationObserving()

  func startedLoadingNextPage()
  func finishedLoadingNextPage(isLastPage: Bool)
}

protocol PaginationObserverDelegate {
  func onLoadNextPage()
}

extension PaginationObserver {
  func startPaginationObserving() {
    paginationFacade.startObserving()
  }

  func stopPaginationObserving() {
    paginationFacade.stopObserving()
  }

  func startedLoadingNextPage() {
    paginationFacade.update(state: .loading, animated: true)
  }

  func finishedLoadingNextPage(isLastPage: Bool) {
    paginationFacade.update(state: .tracking, animated: true)

    if isLastPage {
      paginationFacade.stopObserving()
    }
  }
}
