//
//  DomainManager.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 06/04/21.
//

import Foundation

public protocol DomainManager {
    init(httpClient: HTTPClient)
}

extension DomainManager {
    func completeInMainThread<Arg>(completion: @escaping (Arg, URLRequest?, HTTPURLResponse?) -> Void) -> ((Arg, URLRequest?, HTTPURLResponse?) -> Void) {
        return { arg, urlRequest, urlResponse in
            DispatchQueue.main.async {
                completion(arg, urlRequest, urlResponse)
            }
        }
    }
}
