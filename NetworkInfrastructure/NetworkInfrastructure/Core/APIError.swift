//
//  APIError.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public enum APIError: Error, Equatable, LocalizedError {

    case notAuthenticated(ErrorResponse?)
    case notFound
    case networkProblem
    case badRequest(ErrorResponse?)
    case requestFailed
    case invalidData
    case unknown(HTTPURLResponse?)
    case invalidResponse
    case decodingFailed(String)
    case forbidden
    case serverError(Int, ErrorResponse?)
    case serviceUnavailable(Int)

    case noInternetConnection
    case timeout
    case cancelled

    public var description: String {
        switch self {
        case .notAuthenticated(let response): return "Unauthorized access: \(response?.message ?? "Unknown error")"
        case .notFound: return "Requested resource not found"
        case .networkProblem: return "Network problem occurred"
        case .badRequest: return "Invalid request"
        case .requestFailed: return "Request failed"
        case .invalidData: return "Invalid data received"
        case .unknown: return "Unknown error occurred"
        case .invalidResponse: return "Invalid response from server"
        case .decodingFailed(let message): return "Failed to decode data: \(message)"
        case .forbidden: return "Access forbidden"
        case .serverError: return "Server error"
        case .serviceUnavailable: return "Service temporarily unavailable"
        case .noInternetConnection: return "No internet connection"
        case .timeout: return "Request timed out"
        case .cancelled: return "Request cancelled"
        }
    }

    var isAuthError: Bool {
        switch self {
        case .notAuthenticated: return true
        default: return false
        }
    }

}
