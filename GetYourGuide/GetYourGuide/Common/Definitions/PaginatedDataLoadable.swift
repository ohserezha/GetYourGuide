//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

protocol PaginatedDataLoadable {
  var isLastPage: Bool { get }

  func startLoadingFirstPageData()
  func startLoadingNextPageData()

  func stopLoadingData()
}

protocol PaginatedDataLoadableDelegate: class {
  func didSuccessfullyFinishLoadingFirstPage(_ object: PaginatedDataLoadable)
  func didSuccessfullyFinishLoadingNextPage(_ object: PaginatedDataLoadable)

  func didFailLoadingFirstPage(_ object: PaginatedDataLoadable, with error: APIError)
  func didFailLoadingNextPage(_ object: PaginatedDataLoadable, with error: APIError)
}
