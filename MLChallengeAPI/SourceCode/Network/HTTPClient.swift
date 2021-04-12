//
//  HTTPClient.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 06/04/21.
//

import Foundation

public protocol HTTPClient: class {
    var baseURL: String { get set }
    var headersProvider: HeadersProvider? { get set }

    func execute<Request: HTTPRequest>(
        request: Request,
        completion: @escaping (HTTPResponse<Request.Response>) -> Void
    )
}

public protocol HeadersProvider: class {
    func getHeaders() -> [String: String]
}
