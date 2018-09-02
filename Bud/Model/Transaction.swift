//
//  Transaction.swift
//  Bud
//
//  Created by Ke Ma on 01/09/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    let id: String
    let date: String
    let description: String
    let categoryId: Int
    let currency: String
    let amount: Amount
    let product: Product
}

extension Transaction {
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case description
        case categoryId = "category_id"
        case currency
        case amount
        case product
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        date = try container.decode(String.self, forKey: .date)
        description = try container.decode(String.self, forKey: .description)
        categoryId = try container.decode(Int.self, forKey: .categoryId)
        currency = try container.decode(String.self, forKey: .currency)
        amount = try container.decode(Amount.self, forKey: .amount)
        product = try container.decode(Product.self, forKey: .product)
    }
}

