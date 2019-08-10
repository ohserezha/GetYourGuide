//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import UIKit

protocol PaginationFacade: Observer {
    var delegate: PaginationFacadeDelegate? { get set }

    var presenter: PaginationIndicatorPresenter! { get set }

    var scrollView: UIScrollView? { get set }
    var state: PaginationState { get }

    func update(state: PaginationState, animated: Bool)
}

protocol PaginationFacadeDelegate: class {
    func loadNextPage()
}

protocol PaginationIndicatorPresenter {
    var scrollView: UIScrollView? { get set }

    func presentPaginationIndicator(_ completion: @escaping () -> ())
    func hidePaginationIndicator(_ completion: @escaping () -> ())
}

class PaginationFacadeImpl: PaginationFacade {

    // MARK: - Injected

    var presenter: PaginationIndicatorPresenter!
    var paginationController: PaginationController!

    // MARK: - Public Variables

    weak var delegate: PaginationFacadeDelegate? = nil
    weak var scrollView: UIScrollView? {
        didSet {
            presenter.scrollView = scrollView
            paginationController.scrollView = scrollView
        }
    }
    var state: PaginationState {
        return paginationController.state
    }
    var isObserving: Bool {
        return paginationController.isObserving
    }

    // MARK: - Public

    func update(state: PaginationState, animated: Bool) {
        let completion: () -> () = { [weak self] in
            self?.paginationController.state = state
        }

        if case .loading = state {
            presenter.presentPaginationIndicator(completion)
        } else {
            presenter.hidePaginationIndicator(completion)
        }
    }

    // MARK: - Observer

    func startObserving() {
        paginationController.startObserving()
    }

    func stopObserving() {
        paginationController.stopObserving()
    }
}

extension PaginationFacadeImpl: PaginationControllerDelegate {
    func paginationController(_ controller: PaginationController, scrollViewDidScrollOverThreshold: UIScrollView) {
        delegate?.loadNextPage()
    }
}
