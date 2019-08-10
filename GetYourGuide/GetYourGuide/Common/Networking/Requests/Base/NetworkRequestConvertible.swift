//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import Alamofire


typealias NetworkRequestParameters = [String: Any]

protocol NetworkRequestConvertible: URLRequestConvertible, CustomDebugStringConvertible {
    var method: HTTPMethod { get }
    var url: URL { get }
    var parameters: NetworkRequestParameters { get }
}

extension NetworkRequestConvertible {
    var debugDescription: String {
        return "REQUEST: METHOD - \(method.rawValue) URL - \(url) PARAMETERS - \(parameters)"
    }
}

extension URLRequestConvertible where Self: NetworkRequestConvertible  {
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        return try method.encoding.encode(urlRequest, with: parameters)
    }
}

extension HTTPMethod {
    var encoding: ParameterEncoding {
        switch self {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
        }
    }
}
