//
//  BudEndPoint.swift
//  Bud
//
//  Created by Ke Ma on 29/08/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case staging
    case production
    case test
}

public enum TransactionApi {
    case all
}

extension TransactionApi: ApiType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://production.bud.com/transaction/"
        case .staging: return "https://staging.bud.com/transaction/"
        case .test: return "https://www.mocky.io/v2/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .all:
            return "5b33bdb43200008f0ad1e256"
        }
        
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
    
    var task: HttpTask {
        return .request
    }
    
    var headers: HttpHeaders? {
        return nil
    }
}
