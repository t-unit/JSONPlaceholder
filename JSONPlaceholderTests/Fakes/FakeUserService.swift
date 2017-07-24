//
//  FakeUserService.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

@testable
import JSONPlaceholder

class FakeUserService: UserServing {
    
    var result: Result<[User], Error>?

    func fetch(completionHandler: @escaping UserCompletion) {
        if let result = result {
            completionHandler(result)
        }
    }
}
