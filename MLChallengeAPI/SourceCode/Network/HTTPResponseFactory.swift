//
//  HTTPResponseFactory.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 07/04/21.
//

import Foundation

/**
 Class to build success or failure response.
 */
final class HTTPResponseFactory<Request: HTTPRequest> {
    var urlRequest: URLRequest?
    var httpResponse: HTTPURLResponse?
    
    /**
    Constructor default
     */
    init() {}

    /**
     Function to create success response.
     - Parameter response: generic response of type decodable and codable.
     - Returns: custom HTTPResponse object.
     **/
    func createSuccessResponse(response: Request.Response) -> HTTPResponse<Request.Response> {
        return .init(urlRequest: urlRequest, httpResponse: httpResponse, result: .success(response))
    }

    /**
     Function to create failure response.
     - Parameter error: request error.
     - Returns: custom HTTPResponse object.
     */
    func createFailResponse(error: ServicesResponseError) -> HTTPResponse<Request.Response> {
        return .init(urlRequest: urlRequest, httpResponse: httpResponse, result: .failure(error))
    }
}
