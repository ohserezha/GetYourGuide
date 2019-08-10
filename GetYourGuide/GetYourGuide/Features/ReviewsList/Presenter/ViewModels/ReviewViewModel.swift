//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

struct ReviewViewModel: Equatable {
    let rating: String?
    let title: String?
    let message: String?
    let author: String?
    let date: String?
    let reviewerProfilePhotoURL: URL?
    let reviewerProfilePlaceholderImageName: String
}