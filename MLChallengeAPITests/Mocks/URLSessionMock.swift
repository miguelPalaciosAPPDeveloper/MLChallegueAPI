//
//  URLSessionMock.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation
@testable import MLChallengeAPI

class URLSessionMock: URLSession {
    override init() {}
    
    var sendError: Bool = false
    var sendInternetConnectionError: Bool = false
    
    var completionHandler: ((Data, URLResponse, Error) -> Void)?
    var mockResponse: (data: Data?, URLResponse: URLResponse?, error: Error?)

    class var share: URLSessionMock {
        return URLSessionMock()
    }
        
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.completionHandler = completionHandler
        let succesResponse: [String: String] = [
            "title": "Test", "value": "test finished"
        ]
        
        let response = sendError ? [:] : succesResponse
        
        if !response.isEmpty,
           let jsonData = try? JSONSerialization.data(withJSONObject: response, options: .fragmentsAllowed),
           let url = request.url {
            let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            mockResponse = (jsonData, urlResponse, nil)
        } else {
            let internetError = NSError(domain: "", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
            let mockError: Error = self.sendInternetConnectionError ? internetError : ServicesResponseError.unknown
            mockResponse = (nil, nil, mockError)
        }
        
        return dataTaskMock(response: mockResponse, completionHandler: completionHandler)
    }
}

class dataTaskMock: URLSessionDataTask {
    typealias Response = (data: Data?, URLResponse: URLResponse?, error: Error?)
        var mockResponse: Response
        let completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
        
        init(response: Response, completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) {
            self.mockResponse = response
            self.completionHandler = completionHandler
        }
        
        override func resume() {
            completionHandler?(mockResponse.data, mockResponse.URLResponse, mockResponse.error)
        }
}
