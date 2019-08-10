//
//  Nickolay SheikaNetworkRequestConvertible.swift
//  Nickolay Sheika
//
//  Created by Evgeniy Gurtovoy on 4/5/18.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import Alamofire


protocol GYGNetworkRequestConvertible: NetworkRequestConvertible  {
    var path: String { get }
}

extension GYGNetworkRequestConvertible {
    var url: URL {
        guard let serverBaseURL = serverBaseURL else {
            fatalError("No server base URL provided!")
        }
        return serverBaseURL.appendingPathComponent(path)
    }

    var serverBaseURL: URL? {
        return URL(string: "https://www.getyourguide.com") // in real life this will be injected from environment provider
    }
    
    var debugDescription: String {
        return "REQUEST: METHOD - \(method.rawValue) ENDPOINT - \(path) PARAMETERS - \(parameters)"
    }
}
