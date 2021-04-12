//
//  SiteServicesManagerTest.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 09/04/21.
//

import XCTest
@testable import MLChallengeAPI

class SiteServicesManagerTest: XCTestCase {
    let routerMock = HTTPRouterMock()
    var siteServiceManager: SitesServiceManager?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        siteServiceManager = SitesServiceManagerImplementation(httpClient: routerMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        siteServiceManager = nil
    }
    
    func testGetSites_success() {
        let expectation = self.expectation(description: "getSites")
        var mockResponse: Result<[MLSite], ServicesResponseError>?
        var statusCode = 0
        routerMock.fileName = "MLSitesResponse"
        
        siteServiceManager?.getSites(completion: { (response, _, urlResponse) in
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
    
    func testGetSites_failure() {
        let expectation = self.expectation(description: "getSites")
        var mockResponse: Result<[MLSite], ServicesResponseError>?
        var statusCode = 0
        routerMock.sendMockResponse = false
        
        siteServiceManager?.getSites(completion: { (response, _, urlResponse) in
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
