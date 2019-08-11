//
// Created by Nickolay Sheika on 2019-08-11.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import Swinject
@testable import GetYourGuide

class TestableReviewsListAssembly {

}

// MARK: - Assembly

extension TestableReviewsListAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ReviewsListPresenter.self) { r in
            let presenter = ReviewsListPresenter()
            presenter.interactor = r.resolve(MockReviewsListInteractorInput.self)
            presenter.view = r.resolve(MockReviewsListViewInput.self)
            presenter.viewModelsBuilder = r.resolve(MockReviewsListViewModelsBuilder.self)
            return presenter
        }

        container.register(MockReviewsListInteractorInput.self) { _ in
            MockReviewsListInteractorInput()
        }

        container.register(MockReviewsListViewInput.self) { _ in
            MockReviewsListViewInput()
        }.inObjectScope(.container)

        container.register(MockReviewsListViewModelsBuilder.self) { _ in
            MockReviewsListViewModelsBuilder()
        }
    }
}