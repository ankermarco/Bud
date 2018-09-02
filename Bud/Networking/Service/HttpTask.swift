//
//  HttpTask.swift
//  Bud
//
//  Created by Ke Ma on 29/08/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import Foundation

public typealias HttpHeaders = [String:String]

public enum HttpTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HttpHeaders?)
    
    // case download, upload...etc
}
