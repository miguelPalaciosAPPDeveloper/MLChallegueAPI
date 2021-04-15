//
//  MLSite.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation

public struct MLSite: Codable {
    enum CodingKeys: String, CodingKey {
        case defaultCurrencyID = "default_currency_id"
        case id, name
    }
    
    public let defaultCurrencyID: String
    public let id: String
    public let name: String
    
    public init(defaultCurrencyID: String, id: String, name: String) {
        self.defaultCurrencyID = defaultCurrencyID
        self.id = id
        self.name = name
    }
}
