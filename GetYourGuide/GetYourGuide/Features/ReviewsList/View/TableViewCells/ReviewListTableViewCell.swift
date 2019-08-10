//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import UIKit

class ReviewListTableViewCell: UITableViewCell {

    // MARK: - UI
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()

        userAvatarImageView.cancelImageLoading()
    }
}

extension ReviewListTableViewCell: ModelTransfer {
    func update(with model: ReviewViewModel) {
        reviewTitleLabel.text = model.title
        dateLabel.text = model.date
        ratingLabel.text = model.rating
        reviewTextLabel.text = model.message
        nameLabel.text = model.author
        let placeholderImage = UIImage(named: model.reviewerProfilePlaceholderImageName)
        userAvatarImageView.setImage(with: model.reviewerProfilePhotoURL, placeholder: placeholderImage)
    }
}
