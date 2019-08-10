//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import Alamofire

// abstraction to reduce dependency on Alamofire
protocol NetworkRequest: class {
    func cancel()
}

extension DataRequest: NetworkRequest {
}
