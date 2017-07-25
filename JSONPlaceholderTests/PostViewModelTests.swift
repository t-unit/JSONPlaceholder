//
//  PostViewModelTests.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 25.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import XCTest
import CoreLocation

@testable
import JSONPlaceholder

class PostViewModelTests: XCTestCase {
    
    var sut: PostViewModel!
    
    override func setUp() {
        let post = Post(userIdentifier: 23, identifier: 0, title: "title", body: "the body")
        sut = PostViewModel(post: post)
    }
    
    func testTitle() {
        XCTAssert(sut.title == "title")
    }
    
    func testBody() {
        XCTAssert(sut.body == "the body")
    }
}

