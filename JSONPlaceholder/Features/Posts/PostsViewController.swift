//
//  PostsViewController.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    var viewModel: PostListViewModel!
    
    @IBOutlet
    private weak var tableView: UITableView!
    
    @IBOutlet
    private weak var loadingView: UIView!
    
    @IBOutlet
    private weak var errorView: UIView!
    
    @IBOutlet
    private weak var errorLabel: UILabel!
    
    private var observers: [NSKeyValueObservation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.appear()
    }
    
    @IBAction
    func retryButtonTouchUpInside(_ sender: Any) {
        viewModel.retry()
    }
    
    private func setupView() {
        title = "Posts"
        
        let userCellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(userCellNib, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    
    private func registerObservers() {
        let errorObserver = viewModel.observe(\.errorText) { [weak self] observed, _ in
            self?.errorView.isHidden = observed.errorText == nil
            self?.errorLabel.text = observed.errorText ?? nil
        }
        observers.append(errorObserver)
        
        let loadingObserver = viewModel.observe(\.isLoading) { [weak self] observed, _ in
            self?.loadingView.isHidden = !observed.isLoading
        }
        observers.append(loadingObserver)
        
        let postCountObserver = viewModel.observe(\.postCount) { [weak self] _, _ in
            self?.tableView.reloadData()
        }
        observers.append(postCountObserver)
    }
}

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequed = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath)
        
        if let cell = dequed as? PostTableViewCell {
            cell.viewModel = viewModel.postViewModel(at: indexPath)
        }
        
        return dequed
    }
}

