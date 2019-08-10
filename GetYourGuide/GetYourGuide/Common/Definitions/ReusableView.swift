//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView {
  static func reuseIdentifier() -> String
}

extension ReusableView {
  static func reuseIdentifier() -> String {
    return String(describing: self)
  }
}

// MARK: - UITableViewCell

extension ReusableView where Self: UITableViewCell {
  static func registerFor(tableView: UITableView) {
    tableView.register(nib, forCellReuseIdentifier: Self.reuseIdentifier())
  }
}

extension UITableViewCell: ReusableView {}

// MARK: - UICollectionViewCell

extension ReusableView where Self: UICollectionViewCell {
  static func registerFor(collectionView: UICollectionView) {
    collectionView.register(nib, forCellWithReuseIdentifier: Self.reuseIdentifier())
  }
}

extension UICollectionViewCell: ReusableView {}
