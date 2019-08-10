//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

struct ReviewModel: Decodable {
    let remoteID: Int
    let rating: String?
    let title: String?
    let message: String?
    let author: String?
    let date: String?
    let reviewerProfilePhotoURL: String?
}

extension ReviewModel {
    private enum CodingKeys: String, CodingKey {
        case remoteID = "review_id"
        case rating
        case title
        case message
        case author
        case date
        case reviewerProfilePhotoURL = "reviewerProfilePhoto"
    }
}
