//
//  FakePostService.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 25.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

@testable
import JSONPlaceholder

class FakePostService: PostServing {
    
    var result: Result<[Post], Error>?
    var lastUserIdentifier: Int?
    
    func fetch(userIdentifier: Int, completionHandler: @escaping PostCompletion) {
        lastUserIdentifier = userIdentifier
        
        if let result = result {
            completionHandler(result)
        }
    }
}

