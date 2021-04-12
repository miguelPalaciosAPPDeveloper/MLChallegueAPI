//
//  GetProductByCategory.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation

struct GetProductByCategory: HTTPRequest {
    typealias Response = MLResult
    
    struct Body: Codable {}
    
    let endpoint: String
    let method: HTTPMethod = .get
    let body: Body? = nil
    
    init(site: String, category: String) {
        self.endpoint = String(format: "/sites/%@/search?category=%@", site, category)
    }
}
