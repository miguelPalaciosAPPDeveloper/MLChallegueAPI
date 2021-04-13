//
//  ProductsServiceManagerTest.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 09/04/21.
//

import XCTest
@testable import MLChallengeAPI

class ProductsServiceManagerTest: XCTestCase {
    let routerMock = HTTPRouterMock()
    let query = "KIA Rio"
    var productsServiceManager: ProductsServiceManager?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        productsServiceManager = ProductsServiceManagerImplementation(httpClient: routerMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        productsServiceManager = nil
    }
    
    // MARK: - GetProductsByCategory
    func testGetProductsByCategory_success() {
        let expectation = self.expectation(description: "getProductsByCategory")
        var mockResponse: Result<MLResult, ServicesResponseError>?
        var statusCode = 0
        routerMock.fileName = "MLResultResponse"

        productsServiceManager?.getProductsBy(category: "MLM1747", site: "MLM", completion: { (response, _, urlResponse) in
            mockResponse = response
            if let code = urlResponse?.statusCode { statusCode = code }
            expectation.fulfill()
        })

        waitForExpectations(timeout: 0.25, handler: nil)

        if let response = mockResponse, case let .success(model) = response {
            XCTAssertTrue(!model.products.isEmpty)
            XCTAssertTrue(statusCode == 200)
        }
    }
    
    func testGetProductsByCategory_failure() {
        let expectation = self.expectation(description: "getProductsByCategory")
        var mockResponse: Result<MLResult, ServicesResponseError>?
        var statusCode = 0
        routerMock.sendMockResponse = false

        productsServiceManager?.getProductsBy(category: "MLM1747", site: "MLM", completion: { (response, _, urlResponse) in
            mockResponse = response
            if let code = urlResponse?.statusCode { statusCode = code }
            expectation.fulfill()
        })

        waitForExpectations(timeout: 0.25, handler: nil)

        if let response = mockResponse, case let .failure(error) = response {
            XCTAssertTrue(error == .serverError)
            XCTAssertTrue(statusCode == 500)
        }
    }
    
    // MARK: - GetProductsByQuery
    func testGetProductsByQuery_success() {
        let expectation = self.expectation(description: "getProductsByQuery")
        var mockResponse: Result<MLResult, ServicesResponseError>?
        var statusCode = 0
        routerMock.fileName = "MLResultResponse"

        productsServiceManager?.getProductsBy(query: query, site: "MLM", completion: { (response, _, urlResponse) in
            mockResponse = response
            if let code = urlResponse?.statusCode { statusCode = code }
            expectation.fulfill()
        })

        waitForExpectations(timeout: 0.25, handler: nil)

        if let response = mockResponse, case let .success(model) = response {
            XCTAssertTrue(!model.products.isEmpty)
            XCTAssert(model.query == query)
            XCTAssertTrue(statusCode == 200)
        }
    }
    
    func testGetProductsByQuery_failure() {
        let expectation = self.expectation(description: "getProductsByQuery")
        var mockResponse: Result<MLResult, ServicesResponseError>?
        var statusCode = 0
        routerMock.sendMockResponse = false

        productsServiceManager?.getProductsBy(query: query, site: "MLM", completion: { (response, _, urlResponse) in
            mockResponse = response
            if let code = urlResponse?.statusCode { statusCode = code }
            expectation.fulfill()
        })

        waitForExpectations(timeout: 0.25, handler: nil)

        if let response = mockResponse, case let .failure(error) = response {
            XCTAssertTrue(error == .serverError)
            XCTAssertTrue(statusCode == 500)
        }
    }
}
