//
//  UsersViewController.swift
//  JSONPlaceholder
//
//  Created by Tobias Ottenweller on 24.07.17.
//  Copyright © 2017 Tobias Ottenweller. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    var viewModel = UserListViewModel()

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.appear()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PostsViewController {
            destination.viewModel = viewModel.postListViewModel!
        }
    }

    @IBAction
    func retryButtonTouchUpInside(_ sender: Any) {
        viewModel.retry()
    }

    private func setupView() {
        title = "Users"

        let userCellNib = UINib(nibName: "UserTableViewCell", bundle: nil)
        tableView.register(userCellNib, forCellReuseIdentifier: UserTableViewCell.identifier)
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
        
        let userCountObserver = viewModel.observe(\.userCount) { [weak self] _, _ in
            self?.tableView.reloadData()
        }
        observers.append(userCountObserver)
        
        let postsObserver = viewModel.observe(\.postListViewModel) { [weak self] observed, _ in
            if observed.postListViewModel != nil {
                self?.performSegue(withIdentifier: "posts", sender: self)
            }
        }
        observers.append(postsObserver)
    }
}

extension UsersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UsersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequed = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath)
        
        if let cell = dequed as? UserTableViewCell {
            cell.viewModel = viewModel.userViewModel(at: indexPath)
        }
        
        return dequed
    }
}
