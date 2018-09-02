//
//  NetworkDispatcher.swift
//  Bud
//
//  Created by Ke Ma on 01/09/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import Foundation

public typealias NetworkDispatcherCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol Dispatcher: class {
    associatedtype Route : ApiType
    func exec(_ route: Route, completion: @escaping NetworkDispatcherCompletion)
    func cancel()
}

class NetworkDispatcher<Route: ApiType>: Dispatcher {
    private var task: URLSessionTask?
    
    func exec(_ route: Route, completion: @escaping NetworkDispatcherCompletion) {
        let session = URLSession.shared
        do {
            let apiRequest = try self.buildRequest(from: route)
            task = session.dataTask(with: apiRequest, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
           completion(nil, nil, error)
        }
        task?.resume()
        
    }
    
    func cancel() {
        task?.cancel()
    }
    
    fileprivate func buildRequest(from route: Route) throws -> URLRequest {
        
        var apiRequest = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        apiRequest.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                apiRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &apiRequest)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &apiRequest)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &apiRequest)
            }
            return apiRequest
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HttpHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    
}
