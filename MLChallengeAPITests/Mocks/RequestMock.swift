//
//  RequestMock.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation
@testable import MLChallengeAPI

struct RequestMock: HTTPRequest {
    typealias Response = ResponseMock
    
    struct Body: Codable {
        var serviceID = "requestMock"
    }
    
    let endpoint: String
    let method: HTTPMethod = .get
    let task: HTTPTask = .request
    let body: Body? = Body()
    
    init(endPoint: String) {
        self.endpoint = endPoint
    }
}

struct EmptyRequestMock: HTTPRequest {
    typealias Response = ResponseMock
    
    struct Body: Codable {
        var serviceID: String?
    }
    
    let endpoint: String
    let method: HTTPMethod = .get
    let task: HTTPTask = .request
    let body: Body? = Body()
    
    init(endPoint: String) {
        self.endpoint = endPoint
    }
}
