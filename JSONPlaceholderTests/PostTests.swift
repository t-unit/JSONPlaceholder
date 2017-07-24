//
//  PostTests.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import XCTest
import CoreLocation

@testable
import JSONPlaceholder

class PostTests: XCTestCase {
    
    let decoder = JSONDecoder()
    let jsonString = """
        {
            "userId": 1,
            "id": 1,
            "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            "body": "quia et suscipitsuscipit recusandae consequuntur"
        }
    """
    
    var jsonData: Data {
        return jsonString.data(using: .utf8) ?? Data() // avoid force unwrap
    }
    
    var decoded: Post? {
        return try? decoder.decode(Post.self, from: jsonData)
    }
    
    func testDecode() {
        XCTAssertNoThrow(try {
            try self.decoder.decode(Post.self, from: self.jsonData)
            }())
    }
    
    func testProperties() {
        XCTAssertEqual(decoded?.identifier, 1)
        XCTAssertEqual(decoded?.userIdentifier, 1)
        XCTAssertEqual(decoded?.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(decoded?.body, "quia et suscipitsuscipit recusandae consequuntur")
    }

}
