//
//  GetProductsByQuery.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation

struct GetProductsByQuery: HTTPRequest {
    typealias Response = MLResult
    
    struct Body: Codable {}
    
    let endpoint: String
    let method: HTTPMethod = .get
    let task: HTTPTask = .request
    let body: Body? = nil
    
    init(site: String, query: String) {
        self.endpoint = String(format: "/sites/%@/search?q=%@", site, query)
    }
}
