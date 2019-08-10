//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

struct ReviewsListModel: Decodable {
    let totalCount: Int
    let reviews: [ReviewModel]
}

extension ReviewsListModel {
    private enum CodingKeys: String, CodingKey {
        case reviews = "data"
        case totalCount = "total_reviews_comments"
    }
}

