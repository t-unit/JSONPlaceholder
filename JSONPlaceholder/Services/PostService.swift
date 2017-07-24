//
//  PostService.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

typealias PostCompletion = (Result<[Post], Error>) -> Void

protocol PostServing {
    
    func fetch(userIdentifier: Int, completionHandler: @escaping PostCompletion)
}

struct PostService: PostServing, Service {

    typealias M = [Post]
    
    let session: TaskProviding
    let decoder = JSONDecoder()
    let callbackQueue = DispatchQueue.main
    
    init(session: TaskProviding = URLSession.shared) {
        self.session = session
    }

    func fetch(userIdentifier: Int, completionHandler: @escaping PostCompletion) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userIdentifier)")!
        fetch(url: url, completionHandler: completionHandler)
    }
}
