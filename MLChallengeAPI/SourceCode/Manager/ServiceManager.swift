//
//  ServiceManager.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 06/04/21.
//

import Foundation

final class ServerManager: NSObject, DomainManager {
    private(set) lazy var httpRouter: HTTPClient = {
        let urlSession = URLSession(configuration: .ephemeral,
                                    delegate: nil,
                                    delegateQueue: nil)
        let httpRouter = HTTPRouter(baseURL: MLChallengueAPIConfig.baseStringURL,
                                    urlSession: urlSession)
        return httpRouter
    }()
}

protocol Cancellable {
    func cancel()
}
