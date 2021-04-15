//
//  ResponseModelsTest.swift
//  MLChallengeAPITests
//
//  Created by Miguel Angel De Leon Palacios on 15/04/21.
//

import XCTest
@testable import MLChallengeAPI

class ResponseModelsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - MLSite
    func testMLSiteModel() {
        let model = MLSite(defaultCurrencyID: "MXN", id: "MLM", name: "Mexico")
        XCTAssert(model.id == "MLM")
    }
    
    // MARK: - MLCategory
    func testMLCategoryModel() {
        let model = MLCategory(id: "MLM1747", name: "Accesorios para Vehículos")
        XCTAssert(model.id == "MLM1747")
    }
    
    // MARK: - MLCategoryResult
    func testMLCategoryResultModel() {
        let childrenCategory = [MLChildrenCategory(id: "MLM8531", name: "Navegadores GPS", totalItemsInThisCategory: 29783)]
        var model = MLCategoryResult(id: "MLM1747", name: "Accesorios para Vehículos", totalItemsInThisCategory: 19828552)
        model.childrenCategories = childrenCategory
        
        XCTAssert(model.id == "MLM1747")
        XCTAssert(model.childrenCategories.first?.id == "MLM8531")
    }
    
    // MARK: - MLProduct
    func testMLProductModel() {
        var model = MLResult()
        model.siteID = "MLM"
        let productSort = MLProductSort(id: "relevance", name: "Más relevantes")
        let availableSorts = [
            MLProductSort(id: "price_asc", name: "Menor precio"),
            MLProductSort(id: "price_desc", name: "Mayor precio")
        ]
        var product = MLProduct()
        let productAddress = MLProductAddress(stateID: "MX-NLE", stateName: "Nuevo León", cityID: "TUxNQ1NBTjYzODI", cityName: "San Nicolás De Los Garza")
        let productShipping = MLProductShipping(freeShipping: true, mode: "me2", logisticType: "drop_off", storePickUp: true)
        let installments = MLProductInstallments(quantity: 12, amount: 173.58, currencyID: "MXN")
        let metadata = MLPriceMetadata()
        var price = MLPrice()
        price.metadata = metadata
        var priceAvailable = MLPricesAvailables(id: "MLM792937901")
        priceAvailable.prices = [price]
        
        product.shipping = productShipping
        product.installments = installments
        product.address = productAddress
        
        model.sort = productSort
        model.availableSorts = availableSorts
        
        XCTAssert(model.siteID == "MLM")
    }
}
