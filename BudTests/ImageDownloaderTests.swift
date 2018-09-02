//
//  ImageDownloaderTests.swift
//  BudTests
//
//  Created by Ke Ma on 02/09/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import XCTest

class ImageDownloaderTests: XCTestCase {
    var imageDownloader: ImageDownloader!
    
    override func setUp() {
        super.setUp()
        imageDownloader = ImageDownloader()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloadedWebData() {
        let expectation = XCTestExpectation(description: "Download from mockedurl")
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        imageDownloader.exec(url) { (data, response, error) in
            XCTAssertNil(data, "No data was downloaded")
            if let error = error as NSError? {
                XCTAssertEqual(error.code, -1003, "Sever shouldn't be found")
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
