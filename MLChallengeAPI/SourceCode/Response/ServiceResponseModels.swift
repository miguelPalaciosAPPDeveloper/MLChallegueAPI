//
//  ServiceResponseModels.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 06/04/21.
//

import Foundation

/**
 Custom response with request information.
 */
public struct HTTPResponse<ResponseModel> {
    public let urlRequest: URLRequest?
    public let httpResponse: HTTPURLResponse?
    public let result: Result<ResponseModel, ServicesResponseError>
}

/**
 Common errors for different situations.
 */
public enum ServicesResponseError: Swift.Error, Equatable {
    case unknown
    case noInternetConnection
    case urlBadFormat
    case badResponseCodification(error: Swift.Error)
    case serverError
    case authorizationError
    case httpError(error: Swift.Error?)
    
    public static func == (lhs: ServicesResponseError, rhs: ServicesResponseError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown):
            return true
        case (.noInternetConnection, .noInternetConnection):
            return true
        case (.urlBadFormat, .urlBadFormat):
            return true
        case (.serverError, .serverError):
            return true
        case (.authorizationError, .authorizationError):
            return true
        case (let .httpError(lhsError), let .httpError(rhsError)):
            return lhsError.debugDescription == rhsError.debugDescription
        case (let .badResponseCodification(lhsError), let .badResponseCodification(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
