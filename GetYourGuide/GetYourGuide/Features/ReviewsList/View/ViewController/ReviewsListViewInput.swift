//
//  ReviewsListViewInput.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 10/08/2019.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

protocol ReviewsListViewInput: class, PaginationObserver, CanPresentAlert {
    func updateWith(reviews: [ReviewViewModel])
    func appendWith(reviews: [ReviewViewModel])
}
