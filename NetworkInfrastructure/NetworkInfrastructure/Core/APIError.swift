//
//  APIError.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

enum APIError: Error, Equatable {

    case notAuthenticated
    case notFound
    case networkProblem
    case badRequest
    case requestFailed
    case invalidData
    case unknown(HTTPURLResponse?)
    case invalidResponse
    case decodingFailed
    case forbidden
    case serverError
    case serviceUnavailable

    case noInternetConnection
    case timeout
    case cancelled

    var localizedDescription: String {
        switch self {
        case .notAuthenticated: return "User is not authenticated"
        case .notFound: return "Requested resource not found"
        case .networkProblem: return "Network problem occurred"
        case .badRequest: return "Invalid request"
        case .requestFailed: return "Request failed"
        case .invalidData: return "Invalid data received"
        case .unknown: return "Unknown error occurred"
        case .invalidResponse: return "Invalid response from server"
        case .decodingFailed: return "Failed to decode data"
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
