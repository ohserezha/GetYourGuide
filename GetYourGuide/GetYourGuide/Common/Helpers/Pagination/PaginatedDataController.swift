//
// Created by Nickolay Sheika on 2019-08-11.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

protocol PaginatedDataController {
    var page: Int { get set }
    var limit: Int { get set }
    var allItemsCount: Int? { get set }

    var isLastPage: Bool { get }

    func nextPage()
    func previousPage()
    func resetPagination()
}

class PaginatedDataControllerImpl: PaginatedDataController {

    // MARK: - Public Variables
    var page: Int = 0
    var limit: Int = 10
    var allItemsCount: Int? = nil
    var isLastPage: Bool {
        guard let allItemsCount = allItemsCount else {
            return false
        }
        let pagesCount = Int(Float(allItemsCount).rounded(.up) / Float(limit))
        let pagesLeft = pagesCount - page
        return pagesLeft <= 0
    }

    // MARK: - Public
    func nextPage() {
        guard !isLastPage else {
            return
        }

        page += 1
    }

    func previousPage() {
        guard page != 0 else {
            return
        }

        page -= 1
    }

    func resetPagination() {
        page = 0
        allItemsCount = nil
    }
}