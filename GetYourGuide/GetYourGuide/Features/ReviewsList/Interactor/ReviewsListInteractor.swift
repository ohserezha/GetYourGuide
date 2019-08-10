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

    var tour: TourModel!
}

// MARK: - ReviewsListInteractorInput

extension ReviewsListInteractor: ReviewsListInteractorInput {
    func reloadData() {
        backendService.loadReviewsListFor(tour: tour, page: 0) { result in
            switch (result) {
                case .success(let list):
                    print(list)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
