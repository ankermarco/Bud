//
//  NetworkDispatcherTests.swift
//  BudTests
//
//  Created by Ke Ma on 02/09/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import XCTest

class NetworkDispatcherTests: XCTestCase {
    
    var networkDispatcher: NetworkDispatcher<MockApi>!
    override func setUp() {
        super.setUp()
        
        networkDispatcher = NetworkDispatcher<MockApi>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExecutingNetworkRequest() {
        let expectation = XCTestExpectation(description: "execute network request")
        networkDispatcher.exec(MockApi()) { (data, response, error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 15.0)
    }
    
}
