//
//  ServerManagerTest.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import XCTest
@testable import MLChallengeAPI

class ServerManagerTest: XCTestCase {
    let serverManager = ServerManager()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testProdEnvironment() {
        MLChallengueAPIConfig.environment = .prod
        let isValidBaseURL = serverManager.httpRouter.baseURL == Environment.prod.baseURL
        XCTAssertTrue(isValidBaseURL)
    }
    
    func testDevEnvironment() {
        MLChallengueAPIConfig.environment = .dev
        let isValidBaseURL = serverManager.httpRouter.baseURL == Environment.dev.baseURL
        XCTAssertTrue(isValidBaseURL)
    }
    
    func testHeaders() {
        XCTAssert(serverManager.getHeaders().isEmpty)
    }
}
