//
// Created by Nickolay Sheika on 10/08/2019.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import UIKit

enum Alert {
    case error(message: String)
    case defaultAlert(title: String, message: String)
    case confirmAlert(title: String, message: String, closeAction: AlertActionBlock)
    case errorWithAction(message: String, okAction: AlertActionBlock?)
    case errorWithRetry(message: String, okAction: AlertActionBlock?, retryAction: AlertActionBlock)
}

extension Alert: CustomStringConvertible {
    var description: String {
        switch self {
            case .error(let message):
                return message
            case .errorWithAction(let message, _):
                return message
            case .errorWithRetry(let message, _, _):
                return message
            case .defaultAlert(_, let message):
                return message
            case .confirmAlert(_, let message, _):
                return message
        }
    }
}

extension Alert: PresentableAsAlert {
    func alertController() -> UIAlertController {
        return .alertController(title: title, message: description, actions: actions)
    }
}

private extension Alert {
    var title: String? {
        switch self {
            case .defaultAlert(let title, _):
                return title
            case .confirmAlert(let title, _, _):
                return title
            default:
                return nil
        }
    }

    var actions: [UIAlertAction] {
        switch self {
            case let .confirmAlert(_, _, closeAction):
                return [ .cancelAction(), .closeAction(closeAction) ]
            case let .errorWithAction(_, okAction):
                return [ .okAction(okAction) ]
            case let .errorWithRetry(_, okAction, retryAction):
                return [ .okAction(okAction), .retryAction(retryAction) ]
            default:
                return [ .okAction() ]
        }
    }
}
