//
//  GetSubCategories.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation

struct GetSubCategories: HTTPRequest {
    typealias Response = MLCategoryResult
    
    struct Body: Codable {}
    
    let endpoint: String
    let method: HTTPMethod = .get
    let body: Body? = nil
    
    init(category: String) {
        self.endpoint = String(format: "/categories/%@", category)
    }
}
