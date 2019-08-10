//
// Created by Nickolay Sheika on 10/08/2019.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import UIKit

typealias AlertActionBlock = () -> ()

private extension UIAlertAction {
  static func wrapAction(_ action: AlertActionBlock? = nil) -> (UIAlertAction) -> () {
    return { _ in
      action?()
    }
  }
}

// MARK: - Common

extension UIAlertAction {
  static func okAction(_ action: AlertActionBlock? = nil) -> UIAlertAction {
    return UIAlertAction(title: "Ok", style: .cancel, handler: wrapAction(action))
  }
  
  static func cancelAction(_ action: AlertActionBlock? = nil) -> UIAlertAction {
    return UIAlertAction(title: "Cancel", style: .cancel, handler: wrapAction(action))
  }
  
  static func closeAction(_ action: AlertActionBlock? = nil) -> UIAlertAction {
    return UIAlertAction(title: "Close", style: .default, handler: wrapAction(action))
  }

  static func retryAction(_ action: @escaping AlertActionBlock) -> UIAlertAction {
    return UIAlertAction(title: "Retry", style: .default, handler: wrapAction(action))
  }
}
