//
//  PostListViewModel.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

class PostListViewModel: NSObject {
    
    @objc
    dynamic private(set) var isLoading = false
    
    @objc
    dynamic private(set) var errorText: String? = nil
    
    @objc
    dynamic private(set) var postCount = 0
    
    private var postViewModels: [PostViewModel] = [] {
        didSet {
            postCount = postViewModels.count
        }
    }
    private let service: PostServing
    private let userIdentifier: Int
    
    init(userIdentifier: Int, service: PostServing = PostService()) {
        self.service = service
        self.userIdentifier = userIdentifier
    }
    
    func appear() {
        load()
    }
    
    func postViewModel(at indexPath: IndexPath) -> PostViewModel {
        return postViewModels[indexPath.row]
    }
    
    func retry() {
        errorText = nil
        load()
    }
    
    private func load() {
        isLoading = true
        
        service.fetch(userIdentifier: userIdentifier) { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .failure(let err):
                self?.errorText = err.localizedDescription
            case .success(let users):
                self?.postViewModels = users.map { PostViewModel(post: $0) }
            }
        }
    }
}
