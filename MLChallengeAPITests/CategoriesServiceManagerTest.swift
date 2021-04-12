//
//  CategoriesServiceManagerTest.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 09/04/21.
//

import XCTest
@testable import MLChallengeAPI

class CategoriesServiceManagerTest: XCTestCase {
    let routerMock = HTTPRouterMock()
    var categoriesServicesManager: CategoriesServiceManager?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        categoriesServicesManager = CategoriesServiceManagerImplementation(httpClient: routerMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        categoriesServicesManager = nil
    }
    
    // MARK: - GetCategories
    func testGetCategories_success() {
        let expectation = self.expectation(description: "getCategories")
        var mockResponse: Result<[MLCategory], ServicesResponseError>?
        var statusCode = 0
        routerMock.fileName = "MLCategoriesResponse"
        
        categoriesServicesManager?.getCategories(site: "MLM", completion: { (response, _, urlResponse) in
            mockResponse = response
            if let code = urlResponse?.statusCode { statusCode = code }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        if let response = mockResponse, case let .success(model) = response {
            XCTAssertTrue(!model.isEmpty)
            XCTAssertTrue(statusCode == 200)
        }
    }
    
    func testGetCategories_failure() {
        let expectation = self.expectation(description: "getCategories")
        var mockResponse: Result<[MLCategory], ServicesResponseError>?
        var statusCode = 0
        routerMock.sendMockResponse = false
        
        categoriesServicesManager?.getCategories(site: "MLM", completion: { (response, _, urlResponse) in
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
    
    // MARK: - GetSubcategories
    func testGetSubcategories_success() {
        let expectation = self.expectation(description: "getSubcategories")
        var mockResponse: Result<MLCategoryResult, ServicesResponseError>?
        var statusCode = 0
        routerMock.fileName = "MLSubcategoriesResponse"
        
        categoriesServicesManager?.getSubcategories(category: "MLM1747", completion: { (response, _, urlResponse) in
            mockResponse = response
            if let code = urlResponse?.statusCode { statusCode = code }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        if let response = mockResponse, case let .success(model) = response {
            XCTAssertTrue(!model.childrenCategories.isEmpty)
            XCTAssertTrue(statusCode == 200)
        }
    }
    
    func testGetSubcategories_failure() {
        let expectation = self.expectation(description: "getSubcategories")
        var mockResponse: Result<MLCategoryResult, ServicesResponseError>?
        var statusCode = 0
        routerMock.sendMockResponse = false
        
        categoriesServicesManager?.getSubcategories(category: "MLM1747", completion: { (response, _, urlResponse) in
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
