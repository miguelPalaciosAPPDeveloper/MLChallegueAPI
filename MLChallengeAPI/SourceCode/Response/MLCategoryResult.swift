//
//  MLCategoryResult.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation

// MARK: - Category result
public struct MLCategoryResult: Codable {
    enum CodingKeys: String, CodingKey {
        case pathFromRoot = "path_from_root"
        case totalItemsInThisCategory = "total_items_in_this_category"
        case childrenCategories = "children_categories"
        case id, name, picture, permalink
    }
    
    public let id: String?
    public let name: String?
    public let picture: String?
    public let permalink: String?
    public let pathFromRoot: [MLCategory]?
    public let totalItemsInThisCategory: Int?
    public let childrenCategories: [MLChildrenCategory?]
}

// MARK: - Children category
public struct MLChildrenCategory: Codable {
    enum CodingKeys: String, CodingKey {
        case totalItemsInThisCategory = "total_items_in_this_category"
        case id, name
    }
    
    public let id: String?
    public let name: String?
    public let totalItemsInThisCategory: Int?
}
