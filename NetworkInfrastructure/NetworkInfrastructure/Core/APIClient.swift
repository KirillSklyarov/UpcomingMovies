//
//  APIClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol APIClient {

    var session: URLSession { get }

    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void)

}

extension APIClient {

    typealias JSONTaskCompletionHandler = (Result<Decodable, APIError>) -> Void

    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            decodingType: T.Type,
                                            completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                let apiError = handleURLError(error)
                completion(.failure(apiError))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            guard 200..<300 ~= httpResponse.statusCode else {
                let error = handleHTTPError(httpResponse)
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let genericModel = try decoder.decode(decodingType, from: data)
                completion(.success(genericModel))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        return task
    }

    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let value = decode(json) {
                        completion(.success(value))
                    } else {
                        completion(.failure(.decodingFailed))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

private extension APIClient {

    func handleURLError(_ error: Error) -> APIError {
        guard let urlError = error as? URLError else {
            return .unknown(nil)
        }

        switch urlError.code {
        case .notConnectedToInternet, .networkConnectionLost: return .noInternetConnection
        case .timedOut: return .timeout
        case .cancelled: return .cancelled
        default: return .unknown(nil)
        }
    }

    func handleHTTPError(_ response: HTTPURLResponse) -> APIError {
        switch response.statusCode {
        case 400: return .badRequest
        case 401: return .notAuthenticated
        case 403: return .forbidden
        case 404: return .notFound
        case 500: return .serverError
        default: return .serviceUnavailable
        }
    }

}


