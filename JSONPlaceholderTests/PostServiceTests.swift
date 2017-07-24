//
//  PostServiceTests.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import XCTest
import CoreLocation

@testable
import JSONPlaceholder

class PostServiceTests: XCTestCase {
    
    var sut: PostService!
    var fakeSession: FakeTaskProviding!
    
    override func setUp() {
        fakeSession = FakeTaskProviding()
        sut = PostService(session: fakeSession)
    }
    
    override func tearDown() {
        sut = nil
        fakeSession = nil
    }
    
    func testCorrectEndpoint() {
        sut.fetch(userIdentifier: 45) { _ in }
        XCTAssert(fakeSession.lastURL == URL(string: "https://jsonplaceholder.typicode.com/posts?userId=45"))
    }
}
