//
//  HTTPRequest.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 06/04/21.
//

import Foundation

/**
 Protocol to send http request.
 */
public protocol HTTPRequest {
    associatedtype Body: Codable
    associatedtype Response: Codable
    
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var body: Body? { get }
    var headers: [String: String] { get }
}

// MARK: - Extension for default values
extension HTTPRequest {
    var headers: [String: String] { return [:] }
}

