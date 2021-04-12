//
//  HTTPClientMock.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 09/04/21.
//

import Foundation
@testable import MLChallengeAPI

final class HTTPRouterMock: HTTPClient {
    var baseURL: String = "www.google.com"
    var headersProvider: HeadersProvider?
    
    var sendMockResponse: Bool = true
    var fileName: String = ""
    
    func execute<Request>(request: Request, completion: @escaping (HTTPResponse<Request.Response>) -> Void) where Request : HTTPRequest {
        let responseFactory = HTTPResponseFactory<Request>()
        
        if let url = URL(string: baseURL) {
            let statusCode = sendMockResponse ? 200 : 500
            responseFactory.urlRequest = URLRequest(url: url)
            responseFactory.httpResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            
            guard sendMockResponse else {
                completion(responseFactory.createFailResponse(error: .serverError))
                return
            }
            
            if let model: Request.Response = self.loadDefaultResponse(name: fileName) {
                print("Response: \(model)")
                completion(responseFactory.createSuccessResponse(response: model))
            }
        }
    }
}
