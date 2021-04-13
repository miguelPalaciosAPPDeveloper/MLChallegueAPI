//
//  ServicesConstants.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 06/04/21.
//

import Foundation

enum ServicesConstants {
    static let contentTypeValue = "application/json"
    static let contentTypeKey = "Content-Type"
    static let baseURLProd = "https://api.mercadolibre.com/"
    static let baseURLDev = "https://api.mercadolibre.com/"
    static let httpCodeSuccessRange = 200...299
    static let httpBadRequest = 400
    static let httpResourceNotFound = 404
    static let httpAuthorizationErrorRange = 401...499
    static let timeOutValue: TimeInterval = 6.0
}
