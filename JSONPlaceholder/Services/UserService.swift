//
//  UserService.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

typealias UserCompletion = (Result<[User], Error>) -> Void

protocol UserServing {

    func fetch(completionHandler: @escaping UserCompletion)
}

struct UserService: UserServing, Service {

    typealias M = [User]

    let session: TaskProviding
    let decoder = JSONDecoder()
    let callbackQueue = DispatchQueue.main
    
    init(session: TaskProviding = URLSession.shared) {
        self.session = session
    }
    
    func fetch(completionHandler: @escaping UserCompletion) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        fetch(url: url, completionHandler: completionHandler)
    }
}
