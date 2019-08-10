//
// Created by Nickolay Sheika on 10/08/2019.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import UIKit

protocol CanPresentAlert {
  func presentAlert(_ alert: PresentableAsAlert)
  func presentAlert(_ alert: Alert)
}

extension UIViewController: CanPresentAlert {
}

extension CanPresentAlert where Self: UIViewController {
  func presentAlert(_ alert: PresentableAsAlert) {
    present(alert.alertController(), animated: true)
  }

  func presentAlert(_ alert: Alert) {
    presentAlert(alert as PresentableAsAlert)
  }
}