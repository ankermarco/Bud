//
//  MockApi.swift
//  Bud
//
//  Created by Ke Ma on 02/09/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import Foundation

struct MockApi: ApiType {
    var baseURL: URL {
        guard let url = URL(string: "https://mock.local/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return "somepath/"
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
