//
//  ProductsServiceManager.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 09/04/21.
//

import Foundation

// MARK: - Protocol.
public protocol ProductsServiceManager: DomainManager {
    func getProductsBy(category: String, site: String, completion:  @escaping (Result<MLResult, ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void)
    
    func getProductsBy(query: String, site: String, completion:  @escaping (Result<MLResult, ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void)
}

// MARK: - Implementation.
public final class ProductsServiceManagerImplementation: ProductsServiceManager {
    
    private let httpClient: HTTPClient
    
    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    public func getProductsBy(category: String, site: String, completion: @escaping (Result<MLResult, ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void) {
        let completeInMainThread = self.completeInMainThread(completion: completion)
        let request = GetProductByCategory(site: site, category: category)
        
        httpClient.execute(request: request) { (response) in
            switch response.result {
            case .success(let model):
                completeInMainThread(.success(model), response.urlRequest, response.httpResponse)
            case .failure(let error):
                completeInMainThread(.failure(error), response.urlRequest, response.httpResponse)
            }
        }
    }
    
    public func getProductsBy(query: String, site: String, completion: @escaping (Result<MLResult, ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void) {
        let completeInMainThread = self.completeInMainThread(completion: completion)
        let request = GetProductsByQuery(site: site, query: query)
        
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
