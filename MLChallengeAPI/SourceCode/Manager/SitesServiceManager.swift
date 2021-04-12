//
//  SitesServiceManager.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation

// MARK: - Protocol
public protocol SitesServiceManager: DomainManager {
    func getSites(completion: @escaping (Result<[MLSite], ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void)
}

// MARK: - Implementation.
public final class SitesServiceManagerImplementation: SitesServiceManager {
    
    private let httpClient: HTTPClient
    
    public required init(httpClient: HTTPClient = ServerManager().httpRouter) {
        self.httpClient = httpClient
    }
    
    public func getSites(completion: @escaping (Result<[MLSite], ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void) {
        let completeInMainThread = self.completeInMainThread(completion: completion)
        let request = GetSites()
        
        httpClient.execute(request: request) { (response) in
            switch response.result {
            case .success(let model):
                completeInMainThread(.success(model), response.urlRequest, response.httpResponse)
            case .failure(let error):
                completeInMainThread(.failure(error), response.urlRequest, response.httpResponse)
            }
        }
    }
}
