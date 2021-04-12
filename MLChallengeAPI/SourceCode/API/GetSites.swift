//
//  GetSites.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation

struct GetSites: HTTPRequest {
    typealias Response = [MLSite]
    
    struct Body: Codable {}
    
    let endpoint: String
    let method: HTTPMethod = .get
    let body: Body? = nil
    
    init() {
        self.endpoint = "/sites"
    }
}
