//
//  ReviewsListViewController.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 10/08/2019.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

import UIKit

class ReviewsListViewController: UIViewController {

    // MARK: - UI

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Injected

    var output: ReviewsListViewOutput!
    var dataSource: ArrayTableViewDataSource<ReviewViewModel, ReviewListTableViewCell>!
    var paginationFacade: PaginationFacade!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        paginationFacade.scrollView = tableView
        tableView.dataSource = dataSource

        output.onViewDidLoad()
    }
}

// MARK: - ReviewsListViewInput

extension ReviewsListViewController: ReviewsListViewInput {
    func updateWith(reviews: [ReviewViewModel]) {
        dataSource.updateWith(items: reviews)
        tableView.reloadData()
    }

    func appendWith(reviews: [ReviewViewModel]) {
        dataSource.append(items: reviews)
        tableView.reloadData()
    }
}

// MARK: - PaginationFacadeDelegate

extension ReviewsListViewController: PaginationFacadeDelegate {
    func loadNextPage() {
        output.onLoadNextPage()
    }
}
