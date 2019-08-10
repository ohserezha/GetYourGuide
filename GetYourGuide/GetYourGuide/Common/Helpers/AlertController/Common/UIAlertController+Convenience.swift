//
// Created by Nickolay Sheika on 10/08/2019.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import UIKit

extension UIAlertController {
  static func alertController(title: String?, message: String?, actions: [UIAlertAction], style: UIAlertController.Style = .alert) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)

    for action in actions {
      alert.addAction(action)
    }

    return alert
  }
}
