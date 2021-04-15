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
    public var picture: String?
    public var permalink: String?
    public var pathFromRoot: [MLCategory]
    public let totalItemsInThisCategory: Int?
    public var childrenCategories: [MLChildrenCategory]
    
    public init(id: String?, name: String?, totalItemsInThisCategory: Int?) {
        self.id = id
        self.name = name
        self.totalItemsInThisCategory = totalItemsInThisCategory
        self.picture = nil
        self.permalink = nil
        self.pathFromRoot = []
        self.childrenCategories = []
    }
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
    
    public init(id: String?, name: String?, totalItemsInThisCategory: Int?) {
        self.id = id
        self.name = name
        self.totalItemsInThisCategory = totalItemsInThisCategory
    }
}
