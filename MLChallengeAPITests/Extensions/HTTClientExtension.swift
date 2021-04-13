//
//  HTTClientExtension.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 09/04/21.
//

import UIKit
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
    
    func loadImageData(name: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        guard let image = UIImage(named: name, in: testBundle, with: nil) else {
            return nil
        }
        return image.jpegData(compressionQuality: 1.0)
    }
}
