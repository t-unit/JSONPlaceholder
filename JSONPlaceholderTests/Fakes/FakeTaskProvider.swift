//
//  FakeTaskProvider.swift
//  JSONPlaceholderTests
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

@testable
import JSONPlaceholder

class FakeTaskProviding: TaskProviding {

    var lastTask: FakeURLSessionDataTask?
    var lastURL: URL?

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastURL = url
        
        let task = FakeURLSessionDataTask(completionHandler: completionHandler)
        lastTask = task
        return task
    }
}

class FakeURLSessionDataTask: URLSessionDataTask {

    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    var didResume = false

    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completionHandler = completionHandler
        super.init()
    }

    override func resume() {
        didResume = true
    }
}
