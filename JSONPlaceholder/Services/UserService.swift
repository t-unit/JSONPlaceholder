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

struct UserService: UserServing {

    let session: TaskProviding
    let decoder = JSONDecoder()
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    let callbackQueue = DispatchQueue.main
    
    init(session: TaskProviding = URLSession.shared) {
        self.session = session
    }
    
    func fetch(completionHandler: @escaping UserCompletion) {
        let task = session.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                self.callbackQueue.async { completionHandler(Result(error: error!)) }
                return
            }

            // could be improved by checking response status code and supplying better errors based on it.
            
            do {
                let users = try self.decoder.decode([User].self, from: data ?? Data())
                self.callbackQueue.async { completionHandler(Result(value: users)) }
            } catch {
                self.callbackQueue.async { completionHandler(Result(error: error)) }
            }
        }
        task.resume()
    }
}
