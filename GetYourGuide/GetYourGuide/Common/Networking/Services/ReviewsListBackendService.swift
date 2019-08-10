//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

typealias ReviewsListBackendServiceResult = Result<ReviewsListModel, APIError>

protocol ReviewsListBackendService {
    @discardableResult
    func loadReviewsListFor(tour: TourModel, page: Int, completion: @escaping (ReviewsListBackendServiceResult) -> ()) -> NetworkRequest
}

class ReviewsListBackendServiceImpl: ReviewsListBackendService {
    let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func loadReviewsListFor(tour: TourModel, page: Int, completion: @escaping (ReviewsListBackendServiceResult) -> ()) -> NetworkRequest {
        let request = ReviewsRequest.reviewsList(cityID: tour.city.remoteID, tourID: tour.remoteID, page: page)
        return networkClient.performRequest(request, completion: completion)
    }
}
