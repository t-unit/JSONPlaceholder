//
//  PostTableViewCell.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"
    
    var viewModel: PostViewModel! {
        didSet {
            titleLabel.text = viewModel.title
            bodyLabel.text = viewModel.body
        }
    }

    @IBOutlet
    private weak var titleLabel: UILabel!

    @IBOutlet
    private weak var bodyLabel: UILabel!
}
