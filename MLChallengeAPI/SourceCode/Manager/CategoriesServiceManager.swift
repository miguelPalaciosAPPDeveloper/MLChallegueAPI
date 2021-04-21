//
//  CategoriesServiceManager.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 09/04/21.
//

import Foundation

// MARK: - Protocol
public protocol CategoriesServiceManager: DomainManager {
    func getCategories(site: String, completion: @escaping (Result<[MLCategory], ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void)
    
    func getSubcategories(category: String, completion: @escaping (Result<MLCategoryResult, ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void)
}

// MARK: - Implementation
public final class CategoriesServiceManagerImplementation: CategoriesServiceManager {
    private let httpClient: HTTPClient
    
    public required init(httpClient: HTTPClient = ServerManager().httpRouter) {
        self.httpClient = httpClient
    }
    
    public func getCategories(site: String, completion: @escaping (Result<[MLCategory], ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void) {
        let completeInMainThread = self.completeInMainThread(completion: completion)
        let request = GetCategories(site: site)
        
        httpClient.execute(request: request) { (response) in
            switch response.result {
            case .success(let model):
                completeInMainThread(.success(model), response.urlRequest, response.httpResponse)
            case .failure(let error):
                completeInMainThread(.failure(error), response.urlRequest, response.httpResponse)
            }
        }
    }
    
    public func getSubcategories(category: String, completion: @escaping (Result<MLCategoryResult, ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void) {
        let completeInMainThread = self.completeInMainThread(completion: completion)
        let request = GetSubCategories(category: category)
        
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
