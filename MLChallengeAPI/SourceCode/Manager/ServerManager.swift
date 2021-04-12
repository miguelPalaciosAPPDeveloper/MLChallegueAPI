//
//  ServerManager.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 06/04/21.
//

import Foundation

/**
 Class to make requests.
 */
public final class ServerManager: NSObject {
    public private(set) lazy var httpRouter: HTTPClient = {
        let urlSession = URLSession(configuration: .ephemeral,
                                    delegate: nil,
                                    delegateQueue: nil)
        let httpRouter = HTTPRouter(baseURL: MLChallengueAPIConfig.baseStringURL,
                                    urlSession: urlSession)
        httpRouter.headersProvider = self
        return httpRouter
    }()
}

extension ServerManager: HeadersProvider {
    public func getHeaders() -> [String: String] {
        return [:] // TODO: - you can add more commons header for example authorization bearer.
    }
}

protocol Cancellable {
    func cancel()
}
