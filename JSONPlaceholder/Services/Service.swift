//
//  Service.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

protocol Service {
    
    associatedtype M: Codable
    
    var session: TaskProviding { get }
    var decoder: JSONDecoder { get }
    var callbackQueue: DispatchQueue { get }
}

extension Service {
    
    func fetch(url: URL, completionHandler: @escaping (Result<M, Error>) -> Void) {
        let task = session.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                self.callbackQueue.async { completionHandler(Result(error: error!)) }
                return
            }
            
            // could be improved by checking response status code and supplying better errors based on it.
            
            do {
                let users = try self.decoder.decode(M.self, from: data ?? Data())
                self.callbackQueue.async { completionHandler(Result(value: users)) }
            } catch {
                self.callbackQueue.async { completionHandler(Result(error: error)) }
            }
        }
        task.resume()
    }
}
