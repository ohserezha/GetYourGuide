//
//  ReviewsListAssembly.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 10/08/2019.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class ReviewsListAssembly {

}

// MARK: - Assembly

extension ReviewsListAssembly: Assembly {

    func assemble(container: Container) {
      container.register(ReviewsListModuleFactory.self) { _ in
        return ReviewsListModuleFactory()
      }

      container.register(ReviewsListInteractor.self) { (r, presenter: ReviewsListPresenter) in
        let interactor = ReviewsListInteractor()
        interactor.output = presenter
        interactor.backendService = r.resolve(ReviewsListBackendService.self)
        return interactor
      }

      container.register(ReviewsListRouter.self) { (r, viewController: ReviewsListViewController) in
        let router = ReviewsListRouter()
        router.view = viewController
        return router
      }

      container.register(ReviewsListPresenter.self) { (r, viewController: ReviewsListViewController) in
        let presenter = ReviewsListPresenter()
        presenter.view = viewController
        presenter.interactor = r.resolve(ReviewsListInteractor.self, argument: presenter)
        presenter.router = r.resolve(ReviewsListRouter.self, argument: viewController)
        return presenter
      }

      container.storyboardInitCompleted(ReviewsListViewController.self) { (r, viewController) in
        viewController.output = r.resolve(ReviewsListPresenter.self, argument: viewController)
      }
    }

}
