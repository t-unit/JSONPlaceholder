//
//  UserViewModel.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import Foundation

class UserViewModel {

    let name: String
    let username: String
    let email: String
    let address: String
    
    init(user: User) {
        self.name = user.name
        self.username = user.username
        self.email = user.email
        
        let addressComponents = [user.address.street, user.address.suite, user.address.city, user.address.zipcode]
        self.address = addressComponents.joined(separator: " | ")
    }
}
