//
//  MLProduct.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 08/04/21.
//

import Foundation

// MARK: - Result
public struct MLResult: Codable {
    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case availableSorts = "available_sorts"
        case products = "results"
        case sort, query
    }
    
    public let siteID: String?
    public let query: String?
    public let sort: MLProductSort?
    public let availableSorts: [MLProductSort]
    public let products: [MLProduct]
}

// MARK: - Sort
public struct MLProductSort: Codable {
    public let id: String?
    public let name: String?
}

// MARK: - Product
public struct MLProduct: Codable {
    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case currencyID = "currency_id"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case acceptsMercadopago = "accepts_mercadopago"
        case originalPrice = "original_price"
        case categoryID = "category_id"
        case id, title, price, condition, permalink, thumbnail, installments, shipping, officialStoreID
    }
    
    public let id: String?
    public let siteID: String?
    public let title: String?
    public let price: Double?
    public let currencyID: String?
    public let availableQuantity: Int?
    public let soldQuantity: Int?
    public let condition: String?
    public let permalink: String?
    public let thumbnail: String?
    public let acceptsMercadopago: Bool
    public let installments: MLProductInstallments?
    public let shipping: MLProductShipping?
    public let originalPrice: Double?
    public let categoryID: String?
    public let officialStoreID: Int?
}

// MARK: - Installments
public struct MLProductInstallments: Codable {
    enum CodingKeys: String, CodingKey {
        case currencyID = "currency_id"
        case quantity, amount
    }
    
    public let quantity: Int?
    public let amount: Double?
    public let currencyID: String?
}

// MARK: - Address
public struct MLProductAddress: Codable {
    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case stateName = "stateName"
        case cityID = "city_id"
        case cityName = "city_name"
    }
    
    public let stateID: String
    public let stateName: String
    public let cityID: String
    public let cityName: String
}

// MARK: - Shipping
public struct MLProductShipping: Codable {
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case logisticType = "logistic_type"
        case storePickUp = "store_pick_up"
        case mode
    }
    
    public let freeShipping: Bool
    public let mode: String?
    public let logisticType: String?
    public let storePickUp: Bool
}
