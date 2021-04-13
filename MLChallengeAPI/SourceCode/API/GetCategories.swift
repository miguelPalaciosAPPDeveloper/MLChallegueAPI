//
//  GetCategories.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation

struct GetCategories: HTTPRequest {
    typealias Response = [MLCategory]
    
    struct Body: Codable {}
    
    let endpoint: String
    let method: HTTPMethod = .get
    let task: HTTPTask = .request
    let body: Body? = nil
    
    init(site: String) {
        self.endpoint = String(format: "/sites/%@/categories", site)
    }
}
