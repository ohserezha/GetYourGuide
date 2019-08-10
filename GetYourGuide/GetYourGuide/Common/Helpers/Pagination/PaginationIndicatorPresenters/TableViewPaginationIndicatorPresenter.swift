//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewPaginationIndicatorPresenter: PaginationIndicatorPresenter {
}

class TableViewPaginationIndicatorPresenterImpl: TableViewPaginationIndicatorPresenter {

    // MARK: - UI
    weak var scrollView: UIScrollView?

    // MARK: - Private Variables
    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        UIActivityIndicatorView(style: .gray)
    }()
    private lazy var loadingTableEdgeView: UIView? = { [unowned self] in
        let frame = CGRect(x: 0.0,
                           y: 0.0,
                           width: Double(self.tableView.bounds.size.width),
                           height: Constants.edgeViewHeight)
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.clear
        view.addSubview(self.loadingIndicatorView)
        self.loadingIndicatorView.pinViewToEdgesOfSuperview()
        return view
    }()
    fileprivate var originalTableFooterView: UIView?
    fileprivate var tableView: UITableView {
        return scrollView as! UITableView
    }

    // MARK: - PaginationIndicatorPresenter

    func presentPaginationIndicator(_ completion: @escaping () -> ()) {
        saveOriginalTableEdgeView(tableEdgeView())
        updateTableEdgeView(loadingTableEdgeView)

        self.tableEdgeViewRef(tableEdgeView: { view in
            let frame = CGRect(x: 0.0,
                               y: 0.0,
                               width: Double(self.tableView.bounds.size.width),
                               height: Constants.edgeViewHeight)
            view?.frame = frame
        })
        loadingIndicatorView.startAnimating()
        completion()
    }

    func hidePaginationIndicator(_ completion: @escaping () -> ()) {
        loadingIndicatorView.stopAnimating()

        guard let tableEdgeView = tableEdgeView() else {
            return
        }

        let animationsBlock = {
            let frame = tableEdgeView.frame
            let height = self.tableView.style == .grouped ? CGFloat.leastNormalMagnitude : 0.0
            self.tableEdgeViewRef(tableEdgeView: { view in
                tableEdgeView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: height)
            })
            if self.originalEdgeViewAvailable() {
                self.restoreOriginalTableEdgeView()
            }
        }

        let completionBlock: ((Bool) -> Void)? = {
            finished in
            if !self.originalEdgeViewAvailable() {
                var updatedTableEdgeView = self.tableEdgeView()
                if updatedTableEdgeView != nil {
                    updatedTableEdgeView = nil
                }
            }
            completion()
        }

        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .beginFromCurrentState,
                       animations: animationsBlock,
                       completion: completionBlock)
    }
}

private extension TableViewPaginationIndicatorPresenterImpl {
    private struct Constants {
        static let edgeViewHeight = 50.0
    }

    func tableEdgeView() -> UIView? {
        return tableView.tableFooterView
    }

    func tableEdgeViewRef(tableEdgeView: (inout UIView?) -> Void) {
        return tableEdgeView(&tableView.tableFooterView)
    }

    func saveOriginalTableEdgeView(_ view: UIView?) {
        originalTableFooterView = view
    }

    func updateTableEdgeView(_ view: UIView?) {
        tableView.tableFooterView = view
    }

    func restoreOriginalTableEdgeView() {
        updateTableEdgeView(originalTableFooterView)
    }

    func originalEdgeViewAvailable() -> Bool {
        return originalTableFooterView != nil
    }
}
