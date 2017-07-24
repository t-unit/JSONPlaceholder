//
//  UserTableViewCell.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifier = "UserTableViewCell"

    var viewModel: UserViewModel! {
        didSet {
            nameLabel.text = viewModel.name
            usernameLabel.text = viewModel.username
            emailLabel.text = viewModel.email
            addressLabel.text = viewModel.address
        }
    }

    @IBOutlet
    weak var nameLabel: UILabel!

    @IBOutlet
    weak var usernameLabel: UILabel!

    @IBOutlet
    weak var emailLabel: UILabel!

    @IBOutlet
    weak var addressLabel: UILabel!

}
