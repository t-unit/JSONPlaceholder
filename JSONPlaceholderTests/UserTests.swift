//
//  UserTests.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import XCTest
import CoreLocation

@testable
import JSONPlaceholder

class UserTests: XCTestCase {
    
    let decoder = JSONDecoder()
    let jsonString = """
        {
         "id": 1,
         "name": "Leanne Graham",
         "username": "Bret",
         "email": "Sincere@april.biz",
         "address": {
             "street": "Kulas Light",
             "suite": "Apt. 556",
             "city": "Gwenborough",
             "zipcode": "92998-3874",
             "geo": {
                 "lat": "-37.3159",
                 "lng": "81.1496"
             }
         },
         "phone": "1-770-736-8031 x56442",
         "website": "hildegard.org",
         "company": {
             "name": "Romaguera-Crona",
             "catchPhrase": "Multi-layered client-server neural-net",
             "bs": "harness real-time e-markets"
         }
      }
    """
    
    var jsonData: Data {
        return jsonString.data(using: .utf8) ?? Data() // avoid force unwrap
    }
    
    var decoded: User? {
        return try? decoder.decode(User.self, from: jsonData)
    }
    
    func testDecode() {
        XCTAssertNoThrow(try {
            try self.decoder.decode(User.self, from: self.jsonData)
        }())
    }

    func testUserProperties() {
        XCTAssertEqual(decoded?.identifier, 1)
        XCTAssertEqual(decoded?.name, "Leanne Graham")
        XCTAssertEqual(decoded?.username, "Bret")
        XCTAssertEqual(decoded?.email, "Sincere@april.biz")
        XCTAssertEqual(decoded?.phone, "1-770-736-8031 x56442")
        
        let url = URL(string: "hildegard.org")
        XCTAssertEqual(decoded?.website, url)
    }
    
    func testAddressProperties() {
        let address = decoded?.address
        
        XCTAssertEqual(address?.street, "Kulas Light")
        XCTAssertEqual(address?.suite, "Apt. 556")
        XCTAssertEqual(address?.city, "Gwenborough")
        XCTAssertEqual(address?.zipcode, "92998-3874")
        
        XCTAssertEqual(address?.coordinates.latitude, -37.3159)
        XCTAssertEqual(address?.coordinates.longitude, 81.1496)
    }
    
    func testCompanyProperties() {
        let company = decoded?.company
        
        XCTAssertEqual(company?.name, "Romaguera-Crona")
        XCTAssertEqual(company?.catchPhrase, "Multi-layered client-server neural-net")
        XCTAssertEqual(company?.bs, "harness real-time e-markets")
    }
}
