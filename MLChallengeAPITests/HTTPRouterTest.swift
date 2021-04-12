//
//  HTTPRouterTest.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import XCTest
@testable import MLChallengeAPI

class HTTPRouterTest: XCTestCase {
    var httpRouter: HTTPRouter?
    let urlSessionMock = URLSessionMock.share
    let httpRequest = RequestMock(endPoint: "mock")
    let mockBaseURL = "www.google.com/"
    let responseFactory = HTTPResponseFactory<RequestMock>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        httpRouter = HTTPRouter(baseURL: mockBaseURL,
                                urlSession: urlSessionMock)
        httpRouter?.headersProvider = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        httpRouter = nil
        responseFactory.urlRequest = nil
    }
    
    // MARK: - Execute
    
    func testExecuteFunction_Success() {
        let expectation = self.expectation(description: "execute")
        var mockResponse: HTTPResponse<RequestMock.Response>?
        httpRouter?.execute(request: httpRequest) { (response) in
            mockResponse = response
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.25, handler: nil)

        if let response = mockResponse, case let .success(model) = response.result {
            XCTAssertTrue(model.title == "Test")
            XCTAssertTrue(model.value == "test finished")
        }
    }
    
    func testExecuteFunction_failureInternet() {
        let expectation = self.expectation(description: "execute")
        var mockResponse: HTTPResponse<RequestMock.Response>?
        urlSessionMock.sendError = true
        urlSessionMock.sendInternetConnectionError = true
        httpRouter?.execute(request: httpRequest) { (response) in
            mockResponse = response
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.25, handler: nil)

        if let response = mockResponse, case let .failure(error) = response.result {
            XCTAssertTrue(error == .noInternetConnection)
        }
    }
    
    func testExecuteFunction_failure() {
        let expectation = self.expectation(description: "execute")
        var mockResponse: HTTPResponse<RequestMock.Response>?
        httpRouter?.headersProvider = nil
        urlSessionMock.sendError = true
        httpRouter?.execute(request: httpRequest) { (response) in
            mockResponse = response
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.25, handler: nil)

        if let response = mockResponse, case let .failure(error) = response.result {
            XCTAssertTrue(error == .unknown)
        }
    }
    
    func testExecuteFunction_failureURL() {
        let expectation = self.expectation(description: "execute")
        let httpRequestFail = RequestMock(endPoint: "////////4$$·$")
        var mockResponse: HTTPResponse<RequestMock.Response>?
        urlSessionMock.sendError = true
        urlSessionMock.sendInternetConnectionError = true
        httpRouter?.execute(request: httpRequestFail) { (response) in
            mockResponse = response
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.25, handler: nil)

        if let response = mockResponse, case let .failure(error) = response.result {
            XCTAssertTrue(error == .urlBadFormat)
        }
    }
    
    // MARK: - DecodeResponse.
    func testDecodeResponse_some() {
        if let url = URL(string: mockBaseURL) {
            let errorMock = NSError(domain: "NSCocoaErrorDomain", code: 3840, userInfo: nil)
            let urlRequest = URLRequest(url: url)
            let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            let response = httpRouter?.decodeResponse(request: httpRequest,
                                                      urlRequest: urlRequest,
                                                      httpResponse: urlResponse,
                                                      data: nil,
                                                      error: .some(errorMock))
            if case let .failure(error) = response?.result {
                XCTAssert(error == .httpError(error: errorMock))
            }
        }
    }
    
    func testDecodeResponse_none() {
        if let url = URL(string: mockBaseURL) {
            let urlRequest = URLRequest(url: url)
            let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            let response = httpRouter?.decodeResponse(request: httpRequest,
                                                      urlRequest: urlRequest,
                                                      httpResponse: urlResponse,
                                                      data: .none,
                                                      error: .none)
            if case let .failure(error) = response?.result {
                XCTAssert(error == .serverError)
            }
        }
    }
    
    func testDecodeResponse_decodeError() {
        if let url = URL(string: mockBaseURL) {
            let urlRequest = URLRequest(url: url)
            let errorMock = NSError(domain: "NSCocoaErrorDomain", code: 3840, userInfo: nil)
            let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            let response = httpRouter?.decodeResponse(request: httpRequest,
                                                      urlRequest: urlRequest,
                                                      httpResponse: urlResponse,
                                                      data: .some(Data()),
                                                      error: .none)
            if case let .failure(error) = response?.result {
                XCTAssert(error == .badResponseCodification(error: errorMock))
            }
        }
    }
    
    // MARK: - getResponseBy
    
    func testGetResponseByfunction_badURL() {
        let response = httpRouter?.getResponseBy(statusCode: 200,
                                                 request: httpRequest,
                                                 responseFactory: responseFactory,
                                                 error: nil,
                                                 data: nil)
        if case let .failure(error) = response?.result {
            XCTAssert(error == .urlBadFormat)
        }
    }
    
    func testGetResponseByfunction_badRequest() {
        if let url = URL(string: mockBaseURL) {
            let urlRequest = URLRequest(url: url)
            responseFactory.urlRequest = urlRequest
            let response = httpRouter?.getResponseBy(statusCode: 400,
                                                     request: httpRequest,
                                                     responseFactory: responseFactory,
                                                     error: nil,
                                                     data: nil)
            if case let .failure(error) = response?.result {
                XCTAssert(error == .httpError(error: nil))
            }
        }
    }
    
    func testGetResponseByfunction_resourceNotFound() {
        if let url = URL(string: mockBaseURL) {
            let urlRequest = URLRequest(url: url)
            responseFactory.urlRequest = urlRequest
            let response = httpRouter?.getResponseBy(statusCode: 404,
                                                     request: httpRequest,
                                                     responseFactory: responseFactory,
                                                     error: nil,
                                                     data: nil)
            if case let .failure(error) = response?.result {
                XCTAssert(error == .httpError(error: nil))
            }
        }
    }
    
    func testGetResponseByfunction_authorizationError() {
        if let url = URL(string: mockBaseURL) {
            let urlRequest = URLRequest(url: url)
            responseFactory.urlRequest = urlRequest
            let response = httpRouter?.getResponseBy(statusCode: 401,
                                                     request: httpRequest,
                                                     responseFactory: responseFactory,
                                                     error: nil,
                                                     data: nil)
            if case let .failure(error) = response?.result {
                XCTAssert(error == .authorizationError)
            }
        }
    }
    
    func testGetResponseByfunction_serverError() {
        if let url = URL(string: mockBaseURL) {
            let urlRequest = URLRequest(url: url)
            responseFactory.urlRequest = urlRequest
            let response = httpRouter?.getResponseBy(statusCode: 500,
                                                     request: httpRequest,
                                                     responseFactory: responseFactory,
                                                     error: nil,
                                                     data: nil)
            if case let .failure(error) = response?.result {
                XCTAssert(error == .serverError)
            }
        }
    }
}

// MARK: - HeadersProvider implementation.
extension HTTPRouterTest: HeadersProvider {
    func getHeaders() -> [String : String] {
        return [ServicesConstants.contentTypeKey: ServicesConstants.contentTypeValue]
    }
}
