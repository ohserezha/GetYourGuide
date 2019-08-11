//
// Created by Nickolay Sheika on 2019-08-11.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
@testable import GetYourGuide

class MockReviewsListViewModelsBuilder: ReviewsListViewModelsBuilder {
    var viewModelsToReturn = [ReviewViewModel]()

    func buildFrom(models: [ReviewModel]) -> [ReviewViewModel] {
        return viewModelsToReturn
    }
}