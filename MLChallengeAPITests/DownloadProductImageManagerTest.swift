//
//  DownloadProductImageManagerTest.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 12/04/21.
//

import XCTest
@testable import MLChallengeAPI

class DownloadProductImageManagerTest: XCTestCase {
    let routerMock = HTTPRouterMock()
    var downloadProductImageServiceManager: DownloadProductImageManager?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        downloadProductImageServiceManager = DownloadProductImageManagerImplementation(httpClient: routerMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        downloadProductImageServiceManager = nil
    }
    
    func testDownloadImage_success() {
        let expectation = self.expectation(description: "downloadProductImage")
        var mockResponse: Result<Data, ServicesResponseError>?
        var statusCode = 0
        routerMock.fileName = "meme.jpg"
        
        downloadProductImageServiceManager?.downloadImage(thumbnail: "http://mla-s2-p.mlstatic.com/795558-MLA31003306206_062019-I.jpg", completion: { (response, _, urlResponse) in
            mockResponse = response
            if let code = urlResponse?.statusCode { statusCode = code }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)

        if let response = mockResponse, case let .success(model) = response {
            XCTAssertNotNil(UIImage(data: model))
            XCTAssertTrue(statusCode == 200)
        }
    }
    
    func testDownloadImage_failure() {
        let expectation = self.expectation(description: "downloadProductImage")
        var mockResponse: Result<Data, ServicesResponseError>?
        var statusCode = 0
        routerMock.sendMockResponse = false
        
        downloadProductImageServiceManager?.downloadImage(thumbnail: "http://mla-s2-p.mlstatic.com/795558-MLA31003306206_062019-I.jpg", completion: { (response, _, urlResponse) in
            mockResponse = response
            if let code = urlResponse?.statusCode { statusCode = code }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)

        if let response = mockResponse, case let .failure(error) = response {
            XCTAssertTrue(error == .serverError)
            XCTAssertTrue(statusCode == 500)
        }
    }
}
