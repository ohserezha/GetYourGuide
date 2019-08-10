//
//  ReviewsListViewController.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 10/08/2019.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

import UIKit

class ReviewsListViewController: UIViewController {

    // MARK: - Injected

    var output: ReviewsListViewOutput!

    // MARK: - Lifecycle

    override func viewDidLoad() {
      super.viewDidLoad()
    }

}

// MARK: - ReviewsListViewInput

extension ReviewsListViewController: ReviewsListViewInput {

}
