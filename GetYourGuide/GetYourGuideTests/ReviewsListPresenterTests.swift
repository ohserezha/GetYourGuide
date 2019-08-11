//
//  ReviewsListPresenterTests.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 2019-08-11.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

import XCTest
@testable import GetYourGuide
import Nimble

// Note for reviewer: Had not much time to make good coverage,
// decided to cover only Presenter to show how it's easy to write unit-tests with VIPER
class ReviewsListPresenterTests: BaseTestCase {

    var sut: ReviewsListPresenter!
    var mockView: MockReviewsListViewInput {
        return sut.view as! MockReviewsListViewInput
    }
    var mockInteractor: MockReviewsListInteractorInput {
        return sut.interactor as! MockReviewsListInteractorInput
    }
    var mockViewModelsBuilder: MockReviewsListViewModelsBuilder {
        return sut.viewModelsBuilder as! MockReviewsListViewModelsBuilder
    }

    override func setUp() {
        sut = assembler.resolver.resolve(ReviewsListPresenter.self)
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: - Tests

    func testSetupWithTourSetsTourToInteractor() {
        // When
        let fakeCity = CityModel(remoteID: "fake")
        let fakeTour = TourModel(remoteID: "fake", city: fakeCity)
        sut.setupWith(tour: fakeTour)

        // Then
        expect(self.sut.interactor!.tour).to(equal(fakeTour))
    }

    func testOnViewDidLoadTellsInteractorToStartLoadingFirstPage() {
        // When
        sut.onViewDidLoad()

        // Then
        expect(self.mockInteractor.startLoadingFirstPageDataCall.callsCount) == 1
    }

    func testOnViewDidLoadUpdatesViewStateToLoading() {
        // When
        sut.onViewDidLoad()

        // Then
        expect(self.mockView.updateWithStateCall.callsCount) == 1
        expect(self.mockView.updateWithStateCall.capturedArgument!).to(equal(ReviewsListViewState.loading))
    }

    func testOnLoadNextPageTellsViewItStartedLoading() {
        // When
        sut.onLoadNextPage()

        // Then
        expect(self.mockView.startedLoadingNextPageCall.callsCount) == 1
    }

    func testOnLoadNextPageTellsInteractorToStartLoadingNextPage() {
        // When
        sut.onLoadNextPage()

        // Then
        expect(self.mockInteractor.startLoadingNextPageDataCall.callsCount) == 1
    }

    func testOnSuccessfullyFinishLoadingFirstPageBuildsViewModelsAndProvidesThemToView() {
        // When
        let fake = fakeViewModel()
        mockViewModelsBuilder.viewModelsToReturn = [ fake ]
        sut.didSuccessfullyFinishLoadingFirstPage(mockInteractor)

        // Then
        expect(self.mockView.updateWithReviewsCall.callsCount) == 1
        let viewModel = (self.mockView.updateWithReviewsCall.capturedArgument! as [ReviewViewModel]).first!
        expect(viewModel.title) == fake.title
    }

    func testOnSuccessfullyFinishLoadingFirstPageUpdatesViewStateToShowContentIfHasModels() {
        // When
        mockViewModelsBuilder.viewModelsToReturn = [ fakeViewModel() ]
        sut.didSuccessfullyFinishLoadingFirstPage(mockInteractor)

        // Then
        expect(self.mockView.updateWithStateCall.callsCount) == 1
        expect(self.mockView.updateWithStateCall.capturedArgument!).to(equal(ReviewsListViewState.showContent))
    }

    func testOnSuccessfullyFinishLoadingFirstPageTellsViewToStartPaginationObservingWhenNotLastPage() {
        // When
        mockInteractor.mockIsLastPage = false
        sut.didSuccessfullyFinishLoadingFirstPage(mockInteractor)

        // Then
        expect(self.mockView.startPaginationObservingCall.callsCount) == 1
    }

    func testOnSuccessfullyFinishLoadingFirstPageDoesntTellViewToStartPaginationObservingWhenLastPage() {
        // When
        mockInteractor.mockIsLastPage = true
        sut.didSuccessfullyFinishLoadingFirstPage(mockInteractor)

        // Then
        expect(self.mockView.startPaginationObservingCall.callsCount) == 0
    }

    func testOnSuccessfullyFinishLoadingNextPageBuildsViewModelsAndProvidesThemToView() {
        // When
        let fake = fakeViewModel()
        mockViewModelsBuilder.viewModelsToReturn = [ fake ]
        sut.didSuccessfullyFinishLoadingNextPage(mockInteractor)

        // Then
        expect(self.mockView.appendWithReviewsCall.callsCount) == 1
        let viewModel = (self.mockView.appendWithReviewsCall.capturedArgument! as [ReviewViewModel]).first!
        expect(viewModel.title) == fake.title
    }

    func testOnSuccessfullyFinishLoadingNextPageTellsViewItFinished() {
        // When
        mockInteractor.mockIsLastPage = true
        sut.didSuccessfullyFinishLoadingNextPage(mockInteractor)

        // Then
        expect(self.mockView.finishedLoadingNextPageCall.callsCount) == 1
        expect(self.mockView.finishedLoadingNextPageCall.capturedArgument!).to(beTrue())
    }

    func testOnFailLoadingFirstPageUpdatesViewStateToNoContent() {
        // When
        sut.didFailLoadingFirstPage(mockInteractor, with: .objectSerialization)

        // Then
        expect(self.mockView.updateWithStateCall.callsCount) == 1
        expect(self.mockView.updateWithStateCall.capturedArgument!).to(equal(ReviewsListViewState.noContent))
    }

    func testOnFailLoadingFirstPageTellsViewToPresentAlert() {
        // When
        sut.didFailLoadingFirstPage(mockInteractor, with: .objectSerialization)

        // Then
        expect(self.mockView.presentAlertCall.callsCount) == 1
    }

    func testOnFailLoadingNextPageTellsViewItFinishedLoadingNextPage() {
        // When
        mockInteractor.mockIsLastPage = true
        sut.didFailLoadingNextPage(mockInteractor, with: .objectSerialization)

        // Then
        expect(self.mockView.finishedLoadingNextPageCall.callsCount) == 1
        expect(self.mockView.finishedLoadingNextPageCall.capturedArgument!).to(beTrue())
    }

    func testOnFailLoadingNextPageTellsViewToPresentAlert() {
        // When
        sut.didFailLoadingNextPage(mockInteractor, with: .objectSerialization)

        // Then
        expect(self.mockView.presentAlertCall.callsCount) == 1
    }
}

private extension ReviewsListPresenterTests {
    func fakeViewModel() -> ReviewViewModel {
        let fakeURL = URL(string: "www.google.com")
        let fakeViewModel = ReviewViewModel(rating: "1",
                                            title: "2",
                                            message: "3",
                                            author: "4",
                                            date: "5",
                                            reviewerProfilePhotoURL: fakeURL,
                                            reviewerProfilePlaceholderImageName: "6")
        return fakeViewModel
    }
}