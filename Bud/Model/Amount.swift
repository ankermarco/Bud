//
//  Amount.swift
//  Bud
//
//  Created by Ke Ma on 01/09/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import Foundation

struct Amount: Codable {
    let value: Double
    let currencyISO: String
    
    enum CodingKeys: String, CodingKey {
        case value
        case currencyISO = "currency_iso"
    }
}
