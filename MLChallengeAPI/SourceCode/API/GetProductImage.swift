//
//  GetProductImage.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 12/04/21.
//

import UIKit

struct GetProductImage: HTTPRequest {
    typealias Response = Data
    
    struct Body: Codable {}
    
    let endpoint: String
    let method: HTTPMethod = .get
    let task: HTTPTask = .downloadImage
    let body: Body? = nil
    
    init(thumbnail: String) {
        self.endpoint = thumbnail
    }
}
