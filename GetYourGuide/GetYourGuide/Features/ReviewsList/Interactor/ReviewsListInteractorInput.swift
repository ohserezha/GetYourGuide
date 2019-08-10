//
//  ReviewsListInteractorInput.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 10/08/2019.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

protocol ReviewsListInteractorInput: class {
    var tour: TourModel! { get set }

    func reloadData()
}
