//
//  BudTests.swift
//  BudTests
//
//  Created by Ke Ma on 29/08/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import XCTest
@testable import Bud

class BudTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testURLEncoding() {
        guard let url = URL(string: "https://www.google.com/") else {
            XCTAssertTrue(false, "Could not instantiate url")
            return
        }
        var urlRequest = URLRequest(url: url)
        let parameters: Parameters = ["UserID": 1,
                                      "Name": "Ke",
                                      "Email": "kema2012@gmail.com",
                                      "isCool": true]
        do {
            try URLParameterEncoder().encode(urlRequest: &urlRequest, with: parameters)
            guard let fullURL = urlRequest.url else {
                XCTAssertTrue(false, "urlRequest url is nil.")
                return
            }
            let expectedURL = "https://www.google.com/?Email=kema2012%2540gmail.com&isCool=true&Name=Ke&UserID=1"
            XCTAssertEqual(fullURL.absoluteString, expectedURL)
        }catch {
            
        }
    }
    
    func testJSONEncoding() {
        guard let url = URL(string: "https://www.google.com/") else {
            XCTAssertTrue(false, "Could not instantiate url")
            return
        }
        var urlRequest = URLRequest(url: url)
        let parameters: Parameters = [:]
        do {
            try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: parameters)
            guard let fullURL = urlRequest.url else {
                XCTAssertTrue(false, "urlRequest url is nil.")
                return
            }
            guard let contentTypeHeader = urlRequest.value(forHTTPHeaderField: "Content-Type") else {
                
                return
            }
            let expectedURL = "https://www.google.com/"
            let expectedContentTypeHeader = "application/json"
            XCTAssertEqual(fullURL.absoluteString, expectedURL)
            XCTAssertEqual(contentTypeHeader, expectedContentTypeHeader)
        }catch {
            
        }
    }
    
    func testParameterEncoding() {
        guard let url = URL(string: "https://www.google.com/") else {
            XCTAssertTrue(false, "Could not instantiate url")
            return
        }
        var urlRequest = URLRequest(url: url)
        
        let parameterEncoding = ParameterEncoding.urlAndJsonEncoding
        do {
           try parameterEncoding.encode(urlRequest: &urlRequest, bodyParameters:["email":"test@test.com"], urlParameters: ["username":"ke"])
            
            guard let fullURL = urlRequest.url else {
                XCTAssertTrue(false, "urlRequest url is nil.")
                return
            }
            
            let expectedURL = "https://www.google.com/?username=ke"
            XCTAssertEqual(fullURL.absoluteString, expectedURL)
            
        } catch {}

    }
    
}
