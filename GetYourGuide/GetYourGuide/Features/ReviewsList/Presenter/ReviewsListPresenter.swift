//
//  ReviewsListPresenter.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 10/08/2019.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

class ReviewsListPresenter {

    // MARK: - Injected

    weak var view: ReviewsListViewInput?
    var interactor: ReviewsListInteractorInput!
    var router: ReviewsListRouterInput!
    var viewModelsBuilder: ReviewsListViewModelsBuilder!
}

// MARK: - ReviewsListModuleInput

extension ReviewsListPresenter: ReviewsListModuleInput {
    func setupWith(tour: TourModel) {
        interactor.tour = tour
    }
}

// MARK: - ReviewsListViewOutput

extension ReviewsListPresenter: ReviewsListViewOutput {
    func onViewDidLoad() {
        interactor.startLoadingFirstPageData()
    }

    func onLoadNextPage() {
        view?.startedLoadingNextPage()
        interactor.startLoadingNextPageData()
    }
}

// MARK: - ReviewsListInteractorOutput

extension ReviewsListPresenter: ReviewsListInteractorOutput {
    func didSuccessfullyFinishLoadingFirstPage(_ object: PaginatedDataLoadable) {
        let viewModels = viewModelsBuilder.buildFrom(models: interactor.allReviews)
        view?.updateWith(reviews: viewModels)

        if !object.isLastPage {
            view?.startPaginationObserving()
        }
    }

    func didSuccessfullyFinishLoadingNextPage(_ object: PaginatedDataLoadable) {
        let viewModels = viewModelsBuilder.buildFrom(models: interactor.lastPageDataModels)
        view?.appendWith(reviews: viewModels)
        view?.finishedLoadingNextPage(isLastPage: interactor.isLastPage)
    }

    func didFailLoadingFirstPage(_ object: PaginatedDataLoadable, with error: APIError) {
        view?.presentAlert(.errorWithRetry(message: error.description, okAction: nil, retryAction: {
            self.interactor.startLoadingFirstPageData()
        }))
    }

    func didFailLoadingNextPage(_ object: PaginatedDataLoadable, with error: APIError) {
        view?.finishedLoadingNextPage(isLastPage: object.isLastPage)
        view?.presentAlert(.errorWithRetry(message: error.description, okAction: nil, retryAction: {
            self.interactor.startLoadingNextPageData()
        }))
    }
}
