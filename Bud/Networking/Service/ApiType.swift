//
//  EndPoint.swift
//  Bud
//
//  Created by Ke Ma on 29/08/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import Foundation

protocol ApiType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var task: HttpTask { get }
    var headers: HttpHeaders? { get }
}
