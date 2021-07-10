//
//  NetworkErrorsTests.swift
//  iArtistsTests
//
//  Created by Mike Conner on 7/9/21.
//

import XCTest
@testable import iArtists

class NetworkErrorsTests: XCTestCase {
    
    func functionThatThrowsInvalidURLError() throws {
        throw NetworkError.invalidURL
    }
    
    func functionThatThrowsNoData() throws {
        throw NetworkError.noData
    }
    
    func functionThatThrowsUnableToDecode() throws {
        throw NetworkError.unableToDecode
    }

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testNetworkErrorDescriptions() throws {
        XCTAssertThrowsError(try functionThatThrowsInvalidURLError()) { error in
            XCTAssertTrue(error.localizedDescription == NetworkError.invalidURL.errorDescription)
        }
        
        XCTAssertThrowsError(try functionThatThrowsNoData()) { error in
            XCTAssertTrue(error.localizedDescription == NetworkError.noData.errorDescription)
        }
        
        XCTAssertThrowsError(try functionThatThrowsUnableToDecode()) { error in
            XCTAssertTrue(error.localizedDescription == NetworkError.unableToDecode.errorDescription)
        }
    }

}
