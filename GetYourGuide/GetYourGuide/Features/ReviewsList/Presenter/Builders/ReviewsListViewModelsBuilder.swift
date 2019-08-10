//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

protocol ReviewsListViewModelsBuilder {
    func buildFrom(models: [ReviewModel]) -> [ReviewViewModel]
}

class ReviewsListViewModelsBuilderImpl: ReviewsListViewModelsBuilder {
    func buildFrom(models: [ReviewModel]) -> [ReviewViewModel] {
        return models.map { model in
            buildViewModelFrom(model: model)
        }
    }
}

// Note for reviewer: Usually a lot more data transformation happen here (dates transform, etc)
private extension ReviewsListViewModelsBuilderImpl {
    func buildViewModelFrom(model: ReviewModel) -> ReviewViewModel {
        var url: URL? = nil
        if let reviewerProfilePhotoURL = model.reviewerProfilePhotoURL {
            url = URL(string: reviewerProfilePhotoURL)
        }

        var ratingString = "Unknown"
        if let rating = model.rating {
            ratingString = "Rating: \(rating)"
        }

        return ReviewViewModel(rating: ratingString,
                               title: model.title,
                               message: model.message,
                               author: model.author,
                               date: model.date,
                               reviewerProfilePhotoURL: url, reviewerProfilePlaceholderImageName: "common_avatar_placeholder")
    }
}
