//
//  ReviewsListInteractor.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 10/08/2019.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

class ReviewsListInteractor {

    // MARK: - Injected

    weak var output: ReviewsListInteractorOutput?
    var backendService: ReviewsListBackendService!
    var paginatedDataController: PaginatedDataController!

    // MARK: - Public Variables

    var tour: TourModel!
    var allReviews: [ReviewModel] = []
    var lastPageDataModels: [ReviewModel] = []

    // MARK: - Private Variables

    var currentRequest: NetworkRequest?
}

// MARK: - ReviewsListInteractorInput

extension ReviewsListInteractor: ReviewsListInteractorInput {

    var isLastPage: Bool {
        return paginatedDataController.isLastPage
    }

    func startLoadingFirstPageData() {
        stopLoadingData()
        paginatedDataController.resetPagination()

        currentRequest = backendService.loadReviewsListFor(tour: tour, page: paginatedDataController.page) { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch (result) {
                case .success(let list):
                    strongSelf.allReviews = list.reviews
                    strongSelf.paginatedDataController.allItemsCount = list.totalCount
                    strongSelf.output?.didSuccessfullyFinishLoadingFirstPage(strongSelf)
                case .failure(let error):
                    strongSelf.output?.didFailLoadingFirstPage(strongSelf, with: error)
            }
        }
    }

    func startLoadingNextPageData() {
        paginatedDataController.nextPage()

        currentRequest = backendService.loadReviewsListFor(tour: tour, page: paginatedDataController.page) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch (result) {
                case .success(let list):
                    strongSelf.allReviews.append(contentsOf: list.reviews)
                    strongSelf.lastPageDataModels = list.reviews
                    strongSelf.output?.didSuccessfullyFinishLoadingNextPage(strongSelf)
                case .failure(let error):
                    strongSelf.paginatedDataController.previousPage()
                    strongSelf.output?.didFailLoadingNextPage(strongSelf, with: error)
            }
        }
    }

    func stopLoadingData() {
        currentRequest?.cancel()
    }
}

// MARK: - Private

private extension ReviewsListInteractor {
    func loadData(completion: @escaping (Result<ReviewsListModel, APIError>) -> ()) -> NetworkRequest {
        return backendService.loadReviewsListFor(tour: tour, page: paginatedDataController.page, completion: completion)
    }
}
