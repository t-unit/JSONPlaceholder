//
//  UsersViewModel.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

@objcMembers
class UserListViewModel: NSObject {
    
    dynamic private(set) var isLoading = false
    dynamic private(set) var errorText: String? = nil
    dynamic private(set) var userCount = 0
    
    private var userViewModels: [UserViewModel] = [] {
        didSet {
            userCount = userViewModels.count
        }
    }
    private let service: UserService
    
    init(service: UserService = UserService()) {
        self.service = service
    }
    
    func appear() {
        if userCount == 0 || errorText != nil {
            load()
        }
    }
    
    func userViewModel(at indexPath: IndexPath) -> UserViewModel {
        return userViewModels[indexPath.row]
    }
    
    func retry() {
        errorText = nil
        load()
    }

    func didSelect(at: IndexPath) {
        
    }

    private func load() {
        isLoading = true
        
        service.fetch { [weak self] result in
            self?.isLoading = false
            switch result {
            case .failure(let err):
                self?.errorText = err.localizedDescription
            case .success(let users):
                self?.userViewModels = users.map { UserViewModel(user: $0) }
            }
        }
    }
}
