//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import Alamofire

enum ReviewsRequest {
    case reviewsList(cityID: String, tourID: String, page: Int)
}

extension ReviewsRequest: GYGNetworkRequestConvertible {
    var method: HTTPMethod {
        switch self {
            case .reviewsList:
                return .get
        }
    }

    var path: String {
        switch self {
            case .reviewsList(let cityID, let tourID, _):
                return "/\(cityID)/\(tourID)/reviews.json"
        }
    }

    var parameters: [String: Any] {
        switch self {
            case .reviewsList(_, _, let page):
                return [
                    "sortBy" : Constants.sortBy,
                    "direction" : Constants.direction,
                    "count" : Constants.count,
                    "page" : page
                ]
        }
    }

    var authorized: Bool {
        return false
    }
}

private extension ReviewsRequest {
    struct Constants {
        static let count = 10
        static let sortBy = "date_of_review"
        static let direction = "DESC"
    }
}
