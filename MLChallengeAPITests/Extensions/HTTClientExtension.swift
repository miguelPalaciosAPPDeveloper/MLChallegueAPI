//
//  HTTClientExtension.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 09/04/21.
//

import Foundation
@testable import MLChallengeAPI

extension HTTPClient {
    func loadDefaultResponse<T: Codable>(name: String) -> T? {
        let jsonDecoder = JSONDecoder()
        let testBundle = Bundle(for: type(of: self))
        testBundle.url(forResource: name, withExtension: "json")
        guard let path = testBundle.url(forResource: name, withExtension: "json"),
              let data = try? Data(contentsOf: path, options: .mappedIfSafe) else {
            return nil
        }
        
        return try? jsonDecoder.decode(T.self, from: data)
    }
}
