//
//  MLCategory.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation

public struct MLCategory: Codable {
    public let id: String
    public let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
