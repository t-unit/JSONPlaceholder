//
//  PostViewModel.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

class PostViewModel {
    
    let title: String
    let body: String
    
    init(post: Post) {
        self.title = post.title
        self.body = post.body
    }
}
