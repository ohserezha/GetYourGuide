//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import Swinject

class CommonServicesAssembly {

}

extension CommonServicesAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(PaginationFacade.self) { r in
            let paginationFacade = PaginationFacadeImpl()
            var paginationController = r.resolve(PaginationController.self)!
            paginationFacade.paginationController = paginationController
            paginationController.delegate = paginationFacade
            return paginationFacade
        }

        container.register(PaginationThresholdProvider.self) { _ in
            PaginationDefaultThresholdProvider()
        }

        container.register(PaginationController.self) { r in
            PaginationControllerImpl(thresholdProvider: r.resolve(PaginationThresholdProvider.self)!)
        }

        container.register(TableViewPaginationIndicatorPresenter.self) { r in
            TableViewPaginationIndicatorPresenterImpl()
        }

        container.register(PaginatedDataController.self) { r in
            PaginatedDataControllerImpl()
        }
    }
}