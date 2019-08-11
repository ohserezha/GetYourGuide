//
// Created by Nickolay Sheika on 2019-08-11.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import SwiftyMock
@testable import GetYourGuide

class MockReviewsListViewInput: ReviewsListViewInput {
    let startPaginationObservingCall = FunctionCall<(), ()>()
    func startPaginationObserving() {
        stubCall(startPaginationObservingCall, argument: (), defaultValue: ())
    }

    func stopPaginationObserving() {
    }

    let startedLoadingNextPageCall = FunctionCall<(), ()>()
    func startedLoadingNextPage() {
        stubCall(startedLoadingNextPageCall, argument: (), defaultValue: ())
    }

    let finishedLoadingNextPageCall = FunctionCall<(Bool), ()>()
    func finishedLoadingNextPage(isLastPage: Bool) {
        stubCall(finishedLoadingNextPageCall, argument: (isLastPage), defaultValue: ())
    }

    func presentAlert(_ alert: PresentableAsAlert) {
    }

    let presentAlertCall = FunctionCall<(Alert), ()>()
    func presentAlert(_ alert: Alert) {
        stubCall(presentAlertCall, argument: (alert), defaultValue: ())
    }

    let updateWithStateCall = FunctionCall<(ReviewsListViewState), ()>()
    func updateWith(state: ReviewsListViewState) {
        stubCall(updateWithStateCall, argument: (state), defaultValue: ())
    }

    let updateWithReviewsCall = FunctionCall<([ReviewViewModel]), ()>()
    func updateWith(reviews: [ReviewViewModel]) {
        stubCall(updateWithReviewsCall, argument: (reviews), defaultValue: ())
    }

    let appendWithReviewsCall = FunctionCall<([ReviewViewModel]), ()>()
    func appendWith(reviews: [ReviewViewModel]) {
        stubCall(appendWithReviewsCall, argument: (reviews), defaultValue: ())
    }

    var paginationFacade: PaginationFacade! = nil
}