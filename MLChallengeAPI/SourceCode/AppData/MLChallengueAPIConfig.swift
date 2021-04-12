//
//  MLChallengueAPIConfig.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 07/04/21.
//

import Foundation

/**
 Class to config framework.
 */
public class MLChallengueAPIConfig {
    
    /**
     Varibale to make changes by environment.
     */
    public static var environment: Environment = .dev
    
    /**
     Variable to know the current application version (without function for now).
     */
    public static var appVersion: String = ""
    
    /**
     The internal variable to set a baseURL by environment.
     */
    internal static var baseStringURL: String {
        return MLChallengueAPIConfig.environment.baseURL
    }
}
