//
//  EnvironmentType.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 07/04/21.
//

import Foundation

/**
 Enum to set environment value.
 */
public enum Environment: String, CaseIterable {
    case prod = "PROD"
    case dev = "DEVELOPMENT"
    
    public var baseURL: String {
        switch self {
        case .dev:
            return ServicesConstants.baseURLDev
        case .prod:
            return ServicesConstants.baseURLProd
        }
    }
}
