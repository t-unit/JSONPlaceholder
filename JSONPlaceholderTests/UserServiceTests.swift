//
//  UserServiceTests.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import XCTest
import CoreLocation

@testable
import JSONPlaceholder

class UserServiceTests: XCTestCase {
    
    enum FakeError: Error {
        case test
    }
    
    let jsonString = """
        [
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
      },
      {
        "id": 2,
        "name": "Ervin Howell",
        "username": "Antonette",
        "email": "Shanna@melissa.tv",
        "address": {
          "street": "Victor Plains",
          "suite": "Suite 879",
          "city": "Wisokyburgh",
          "zipcode": "90566-7771",
          "geo": {
            "lat": "-43.9509",
            "lng": "-34.4618"
          }
        },
        "phone": "010-692-6593 x09125",
        "website": "anastasia.net",
        "company": {
          "name": "Deckow-Crist",
          "catchPhrase": "Proactive didactic contingency",
          "bs": "synergize scalable supply-chains"
        }
      }
     ]
    """
    
    var jsonData: Data {
        return jsonString.data(using: .utf8) ?? Data() // avoid force unwrap
    }
    
    var sut: UserService!
    var fakeSession: FakeTaskProviding!
    
    override func setUp() {
        fakeSession = FakeTaskProviding()
        sut = UserService(session: fakeSession)
    }
    
    override func tearDown() {
        sut = nil
        fakeSession = nil
    }
    
    func testResumes() {
        sut.fetch { _ in }
        XCTAssert(fakeSession.lastTask?.didResume == true)
    }
    
    func testCorrectEndpoing() {
        sut.fetch { _ in }
        XCTAssert(fakeSession.lastURL == URL(string: "https://jsonplaceholder.typicode.com/users"))
    }

    func testSucceeds() {
        var completionCalled = false

        sut.fetch {
            XCTAssert($0.value != nil)
            completionCalled = true
        }

        fakeSession.lastTask?.completionHandler(jsonData, nil, nil)
        XCTAssertTrue(completionCalled)
    }
    
    func testFailsOnWrongData() {
        var completionCalled = false
        
        sut.fetch {
            XCTAssert($0.error != nil)
            completionCalled = true
        }
        
        fakeSession.lastTask?.completionHandler(nil, nil, nil)
        XCTAssertTrue(completionCalled)
    }
    
    func testFailsOnError() {
        var completionCalled = false
        
        sut.fetch {
            switch $0.error {
            case is FakeError: break
            default: XCTFail()
            }
            completionCalled = true
        }
        
        fakeSession.lastTask?.completionHandler(jsonData, nil, FakeError.test)
        XCTAssertTrue(completionCalled)
    }
}

