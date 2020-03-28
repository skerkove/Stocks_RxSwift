//
//  Stock.swift
//  Stocks_RxSwift
//
//  Created by Scott Kerkove on 3/25/20.
//  Copyright © 2020 Scott Kerkove. All rights reserved.
//

import Foundation
import UIKit


struct StockListModel: Codable {
    var mostActiveStock: [StockModel]
}

struct StockModel: Codable {
    var companyName: String
    var changesPercentage: String
    var price: String
    var changes: Double
    var ticker: String
}

//##########################################################################

// MARK: - DetailsListModel
struct DetailListModel: Codable {
    let symbol: String
    let profile: Profile
}

// MARK: - Profile
struct Profile: Codable {
    var price: Double?
    var beta, volAvg, mktCap, lastDiv: String?
    var range: String?
    var changes: Double?
    var changesPercentage, companyName, exchange, industry: String?
    var website: String?
    var description, ceo, sector: String?
    var image: String?

}
