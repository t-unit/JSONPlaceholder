//
//  UserLIstViewModelTests.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import XCTest
import CoreLocation

@testable
import JSONPlaceholder

class UserListViewModelTests: XCTestCase {
    
    struct FakeError: LocalizedError {

        public var errorDescription: String? {
            return "errorDescription"
        }
    }
    
    var userList: [User] {
        let coordinates1 = CLLocationCoordinate2D(latitude: 50, longitude: 10)
        let address1 = User.Address(street: "Main Street", suite: "A", city: "New York", zipcode: "123", coordinate: coordinates1)
        let company1 = User.Company(name: "ASDF", catchPhrase: "QWERTY", bs: "exclusive data-driven AI matching")
        let user1 = User(identifier: 0, name: "Peter", username: "Pete", email: "pete@gmail.com", address: address1, phone: "0011", website: URL(string: "localhost")!, company: company1)
        
        let coordinates2 = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let address2 = User.Address(street: "2nd Street", suite: "33d", city: "New York", zipcode: "123", coordinate: coordinates2)
        let company2 = User.Company(name: "ASDF", catchPhrase: "QWERTY", bs: "exclusive data-driven AI matching")
        let user2 = User(identifier: 0, name: "Steve", username: "S", email: "s@gmail.com", address: address2, phone: "0011", website: URL(string: "google.com")!, company: company2)
        
        return [user1, user2]
    }

    var fakeService: FakeUserService!
    var sut: UserListViewModel!
    
    override func setUp() {
        fakeService = FakeUserService()
        sut = UserListViewModel(service: fakeService)
    }
    
    override func tearDown() {
        sut = nil
        fakeService = nil
    }
    
    func testAppearLoads() {
        sut.appear()
        XCTAssertTrue(sut.isLoading)
    }
    
    func testInitalNoError() {
        XCTAssertNil(sut.errorText)
    }
    
    func testLoadingError() {
        fakeService.result = Result(error: FakeError())
        sut.appear()
        XCTAssertEqual(sut.errorText, "errorDescription")
        XCTAssertFalse(sut.isLoading)
    }

    func testReload() {
        fakeService.result = Result(error: FakeError())
        sut.appear()
        fakeService.result = nil
        
        sut.retry()
        XCTAssertTrue(sut.isLoading)
    }
    
    func testSucces() {
        fakeService.result = Result(value: userList)
        sut.appear()
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.userCount, 2)

        XCTAssertEqual(sut.userViewModel(at: IndexPath(row: 0, section: 0)).name, "Peter")
        XCTAssertEqual(sut.userViewModel(at: IndexPath(row: 1, section: 0)).name, "Steve")
    }

    func testReappear() {
        fakeService.result = Result(value: userList)
        sut.appear()
        fakeService.result = nil
        
        sut.appear()
        XCTAssertFalse(sut.isLoading)
    }

    func testSelectionSetsViewModel() {
        fakeService.result = Result(value: userList)
        sut.appear()
        
        sut.didSelect(at: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(sut.postListViewModel)
    }
}
