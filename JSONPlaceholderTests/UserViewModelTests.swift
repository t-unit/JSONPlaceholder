//
//  UserViewModelTests.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import XCTest
import CoreLocation

@testable
import JSONPlaceholder

class UserViewModelTests: XCTestCase {

    var sut: UserViewModel!

    override func setUp() {
        let coordinates = CLLocationCoordinate2D(latitude: 50, longitude: 10)
        let address = User.Address(street: "Main Street", suite: "A", city: "New York", zipcode: "123", coordinate: coordinates)
        let company = User.Company(name: "ASDF", catchPhrase: "QWERTY", bs: "exclusive data-driven AI matching")
        let user = User(identifier: 0, name: "Peter", username: "Pete", email: "pete@gmail.com", address: address, phone: "0011", website: URL(string: "localhost")!, company: company)
        
        sut = UserViewModel(user: user)
    }
    
    func testName() {
        XCTAssert(sut.name == "Peter")
    }

    func testUsername() {
        XCTAssert(sut.username == "Pete")
    }

    func testEmail() {
        XCTAssert(sut.email == "pete@gmail.com")
    }

    func testAddress() {
        XCTAssert(sut.address.contains("Main Street"))
        XCTAssert(sut.address.contains("A"))
        XCTAssert(sut.address.contains("New York"))
        XCTAssert(sut.address.contains("123"))
    }
}
