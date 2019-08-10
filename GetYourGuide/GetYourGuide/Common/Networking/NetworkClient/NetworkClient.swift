//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkClientResponse<Model: Decodable> = Swift.Result<Model, APIError>
typealias NetworkClientCompletion<Model: Decodable> = (NetworkClientResponse<Model>) -> ()

protocol NetworkClient {
    @discardableResult
    func performRequest<Model: Decodable>(_ request: NetworkRequestConvertible,
                                          completion: @escaping NetworkClientCompletion<Model>) -> NetworkRequest
}

final class NetworkClientImpl: NetworkClient {

    // MARK: - Injected

    var decoder: JSONDecoderType!

    // MARK: - Public

    @discardableResult
    func performRequest<Model: Decodable>(_ request: NetworkRequestConvertible,
                                          completion: @escaping NetworkClientCompletion<Model>) -> NetworkRequest {
        return Alamofire.request(request).responseData { response in
            completion(self.handleResponse(response))
        }
    }
}

private extension NetworkClientImpl {
    func handleResponse<Model: Decodable>(_ response: DataResponse<Data>) -> NetworkClientResponse<Model> {
        let statusCode = response.response?.statusCode

        switch (response.result, statusCode) {
            case (.success, let statusCode?) where (400...500).contains(statusCode):
                return .failure(.backend(message: "Something went wrong"))
            case (.success(let data), _):
                do {
                    let model: Model = try decodeModelFrom(data: data)
                    return .success(model)
                } catch let error as APIError {
                    return .failure(error)
                } catch {
                    return .failure(.objectSerialization)
                }
            case (.failure(let error), _):
                return .failure(wrapError(error))
        }
    }

    func decodeModelFrom<Model: Decodable>(data: Data) throws -> Model {
        let status = try self.decodeStatusFrom(data: data)

        if status {
            return try decoder.decode(Model.self, from: data)
        } else {
            let messageModel = try decoder.decode(NetworkResponseMessage.self, from: data)
            throw APIError.backend(message: messageModel.message)
        }
    }

    func decodeStatusFrom(data: Data) throws -> Bool {
        do {
            let model = try decoder.decode(NetworkResponseStatus.self, from: data)
            return model.status
        } catch {
            throw APIError.objectSerialization
        }
    }

    func wrapError(_ error: Error) -> APIError {
        if (error as NSError).code == NSURLErrorCancelled {
            return APIError.cancelled
        }
        return APIError.network(description: error.localizedDescription)
    }
}

struct NetworkResponseStatus: Decodable {
    let status: Bool
}

struct NetworkResponseMessage: Decodable {
    let message: String
}
