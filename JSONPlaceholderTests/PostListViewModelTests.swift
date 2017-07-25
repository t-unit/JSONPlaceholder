//
//  PostListViewModelTests.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 25.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import XCTest
import CoreLocation

@testable
import JSONPlaceholder

class PostListViewModelTests: XCTestCase {
    
    struct FakeError: LocalizedError {
        
        public var errorDescription: String? {
            return "errorDescription"
        }
    }
    
    var postList: [Post] {
        let post1 = Post(userIdentifier: 0, identifier: 0, title: "a", body: "b")
        let post2 = Post(userIdentifier: 0, identifier: 1, title: "c", body: "d")
        
        return [post1, post2]
    }
    
    var fakeService: FakePostService!
    var sut: PostListViewModel!
    
    override func setUp() {
        fakeService = FakePostService()
        sut = PostListViewModel(userIdentifier: 0, service: fakeService)
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
        fakeService.result = Result(value: postList)
        sut.appear()
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.postCount, 2)
        
        XCTAssertEqual(sut.postViewModel(at: IndexPath(row: 0, section: 0)).title, "a")
        XCTAssertEqual(sut.postViewModel(at: IndexPath(row: 1, section: 0)).title, "c")
    }
}
