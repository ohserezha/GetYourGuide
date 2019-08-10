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
        interactor.reloadData()
    }
}

// MARK: - ReviewsListInteractorOutput

extension ReviewsListPresenter: ReviewsListInteractorOutput {

}
