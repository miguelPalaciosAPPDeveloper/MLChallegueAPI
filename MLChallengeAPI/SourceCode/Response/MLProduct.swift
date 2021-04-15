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
    
    public var siteID: String?
    public var query: String?
    public var sort: MLProductSort?
    public var availableSorts: [MLProductSort]
    public var products: [MLProduct]
    
    public init() {
        self.siteID = nil
        self.query = nil
        self.sort = nil
        self.availableSorts = []
        self.products = []
    }
}

// MARK: - Sort
public struct MLProductSort: Codable {
    public let id: String
    public let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
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
        case id, title, price, condition, permalink, thumbnail, installments, shipping, officialStoreID, address, prices
    }
    
    public var id: String?
    public var siteID: String?
    public var title: String?
    public var price: Double?
    public var currencyID: String?
    public var availableQuantity: Int?
    public var soldQuantity: Int?
    public var condition: String?
    public var permalink: String?
    public var thumbnail: String?
    public var acceptsMercadopago: Bool
    public var installments: MLProductInstallments?
    public var shipping: MLProductShipping?
    public var address: MLProductAddress?
    public var prices: MLPricesAvailables?
    public var originalPrice: Double?
    public var categoryID: String?
    public var officialStoreID: Int?
    
    public init() {
        self.id = nil
        self.siteID = nil
        self.title = nil
        self.price = nil
        self.currencyID = nil
        self.availableQuantity = nil
        self.soldQuantity = nil
        self.condition = nil
        self.permalink = nil
        self.thumbnail = nil
        self.acceptsMercadopago = false
        self.installments = nil
        self.shipping = nil
        self.originalPrice = nil
        self.categoryID = nil
        self.officialStoreID = nil
        self.prices = nil
    }
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
    
    public init(quantity: Int?, amount: Double?, currencyID: String?) {
        self.quantity = quantity
        self.amount = amount
        self.currencyID = currencyID
    }
}

// MARK: - Address
public struct MLProductAddress: Codable {
    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case stateName = "state_name"
        case cityID = "city_id"
        case cityName = "city_name"
    }
    
    public let stateID: String
    public let stateName: String
    public let cityID: String
    public let cityName: String
    
    public init(stateID: String, stateName: String, cityID: String, cityName: String) {
        self.stateID = stateID
        self.stateName = stateName
        self.cityID = cityID
        self.cityName = cityName
    }
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
    
    public init(freeShipping: Bool, mode: String?, logisticType: String?, storePickUp: Bool) {
        self.freeShipping = freeShipping
        self.mode = mode
        self.logisticType = logisticType
        self.storePickUp = storePickUp
    }
}

// MARK: - PricesAvailables
public struct MLPricesAvailables: Codable {
    public let id: String
    public var prices: [MLPrice]
    
    public init(id: String) {
        self.id = id
        self.prices = []
    }
}

// MARK: - Price
public struct MLPrice: Codable {
    enum CodingKeys: String, CodingKey {
        case regularAmount = "regular_amount"
        case exchangeRateContext = "exchange_rate_context"
        case currencyID = "currency_id"
        case lastUpdated = "last_updated"
        case id, type, amount, metadata
    }
    
    public var id: String?
    public var type: String?
    public var amount: Double?
    public var regularAmount: Double?
    public var exchangeRateContext: String?
    public var currencyID: String?
    public var lastUpdated: String?
    public var metadata: MLPriceMetadata?
    
    public init() {
        self.id = nil
        self.type = nil
        self.amount = nil
        self.regularAmount = nil
        self.exchangeRateContext = nil
        self.currencyID = nil
        self.lastUpdated = nil
        self.metadata = nil
    }
}

// MARK: - PriceMetadata
public struct MLPriceMetadata: Codable {
    enum CodingKeys: String, CodingKey {
        case campaignID = "campaign_id"
        case promotionID = "promotion_id"
        case promotionType = "promotion_type"
        case discountMeliAmount = "discount_meli_amount"
        case campaignDiscountPercentage = "campaign_discount_percentage"
        case campaignEndDate = "campaign_end_date"
        case orderItemPrice = "order_item_price"
    }
    
    public var campaignID: String?
    public var promotionID: String?
    public var promotionType: String?
    public var discountMeliAmount: Double?
    public var campaignDiscountPercentage: Double?
    public var campaignEndDate: String?
    public var orderItemPrice: Double?
    
    public init() {
        self.campaignID = nil
        self.promotionID = nil
        self.promotionType = nil
        self.discountMeliAmount = nil
        self.campaignDiscountPercentage = nil
        self.campaignEndDate = nil
        self.orderItemPrice = nil
    }
}
