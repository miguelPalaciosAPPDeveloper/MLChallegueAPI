//
//  DownloadProductImageManager.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 12/04/21.
//

import UIKit

// MARK: - Protocol.
public protocol DownloadProductImageManager: DomainManager {
    func downloadImage(thumbnail: String, completion:  @escaping (Result<Data, ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void)
}

// MARK: - Implementation.
public final class DownloadProductImageManagerImplementation: DownloadProductImageManager {
    private let httpClient: HTTPClient
    
    public required init(httpClient: HTTPClient = ServerManager().httpRouter) {
        self.httpClient = httpClient
    }
    
    public func downloadImage(thumbnail: String, completion: @escaping (Result<Data, ServicesResponseError>, URLRequest?, HTTPURLResponse?) -> Void) {
        let completeInMainThread = self.completeInMainThread(completion: completion)
        let request = GetProductImage(thumbnail: thumbnail)
        
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
