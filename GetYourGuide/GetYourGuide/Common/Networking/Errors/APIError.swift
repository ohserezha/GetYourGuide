//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation

enum APIError: CustomStringConvertible, Error {
    case backend(message: String)
    case network(description: String)
    case objectSerialization
    case cancelled

    var description: String {
        switch self {
            case .backend(let message):
                return "Backend Error: \n\(message)"
            case .network(let localizedDescription):
                return "Network Error: \n\(localizedDescription)"
            case .objectSerialization:
                return "Backend Error: \nBad Response Format"
            case .cancelled:
                return "Cancelled"
        }
    }
}
