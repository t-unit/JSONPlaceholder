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
    weak var tableView: UITableView!

    @IBOutlet
    weak var loadingView: UIView!
    
    @IBOutlet
    weak var errorView: UIView!
    
    @IBOutlet
    weak var errorLabel: UILabel!
    
    private var errorObserver: NSKeyValueObservation?
    private var loadingObserver: NSKeyValueObservation?
    private var userCountObserver: NSKeyValueObservation?
    
    deinit {
        // remove oberservers
    }

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
        let userCellNib = UINib(nibName: "UserTableViewCell", bundle: nil)
        tableView.register(userCellNib, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    private func registerObservers() {
        errorObserver = viewModel.observe(\UserListViewModel.errorText) { [weak self] observed, _ in
            self?.errorView.isHidden = observed.errorText == nil
            self?.errorLabel.text = observed.errorText ?? nil
        }
        
        loadingObserver = viewModel.observe(\UserListViewModel.isLoading) { [weak self] observed, _ in
            self?.loadingView.isHidden = !observed.isLoading
        }
        
        userCountObserver = viewModel.observe(\UserListViewModel.userCount) { [weak self] _, _ in
            self?.tableView.reloadData()
        }
    }
}

extension UsersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
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
