//
// Created by Nickolay Sheika on 2019-08-11.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import SwiftyMock
@testable import GetYourGuide

class MockReviewsListInteractorInput: ReviewsListInteractorInput {
    private(set) var allReviews: [ReviewModel] = []
    private(set) var lastPageDataModels: [ReviewModel] = []

    var tour: TourModel!

    var mockIsLastPage: Bool = false
    var isLastPage: Bool {
        return mockIsLastPage
    }

    let startLoadingFirstPageDataCall = FunctionCall<(), ()>()

    func startLoadingFirstPageData() {
        stubCall(startLoadingFirstPageDataCall, argument: (), defaultValue: ())
    }

    let startLoadingNextPageDataCall = FunctionCall<(), ()>()

    func startLoadingNextPageData() {
        stubCall(startLoadingNextPageDataCall, argument: (), defaultValue: ())
    }

    func stopLoadingData() {
    }
}