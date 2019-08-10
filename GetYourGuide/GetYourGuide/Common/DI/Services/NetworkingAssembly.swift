//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import Swinject

class NetworkingAssembly {

}

extension NetworkingAssembly: Assembly {

    func assemble(container: Container) {
        container.register(NetworkClient.self) { r in
            let client = NetworkClientImpl()
            client.decoder = r.resolve(JSONDecoderType.self)
            return client
        }

        container.register(ReviewsListBackendService.self) { r in
            let networkClient = r.resolve(NetworkClient.self)!
            return ReviewsListBackendServiceImpl(networkClient: networkClient)
        }

        container.register(JSONDecoderType.self) { _ in
            JSONDecoder()
        }
    }

}