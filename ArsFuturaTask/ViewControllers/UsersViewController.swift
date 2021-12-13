//
//  UsersViewController.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 17.11.2021.
//

import UIKit

final class UsersViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private lazy var usersView: UsersView = {
        let usersView = UsersView()
        usersView.usersTableView.delegate = self
        usersView.usersTableView.dataSource = self
        usersView.searchBar.delegate = self
        return usersView
    }()
    
    private var usersViewModel: UsersViewModelProtocol
    private var timer: Timer?
    private var currentPage = 1
    
    // MARK: - INIT
    
    init(viewModel: UsersViewModelProtocol) {
        self.usersViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = usersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        initViewModelBinding()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupNavigation() {
        extendedLayoutIncludesOpaqueBars = true
        
        navigationItem.titleView = usersView.searchBar
        navigationController?.hideHairline()
    }
    
    private func initViewModelBinding() {
        usersViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.usersView.usersTableView.reloadData()
            }
        }
        
        usersViewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.usersViewModel.isLoading ?? false
                if isLoading {
                    self?.usersView.activityIndicator.startAnimating()
                } else {
                    self?.usersView.activityIndicator.stopAnimating()
                }
            }
        }
        
        usersViewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.usersViewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        usersViewModel.getUsers()
    }
}

// MARK: - TABLE VIEW DATA SOURCE

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel.usersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.UserCellReuseIdentifier, for: indexPath) as? UserCell else { return UITableViewCell() }

        let user = usersViewModel.getUserCellModel(at: indexPath)
        cell.avatarImageView.loadImage(at: user.avatarUrl)
        cell.loginNameLabel.text = user.login
        cell.htmlUrlLabel.text = user.htmlUrl

        return cell
    }
}

// MARK: - TABLE VIEW DELEGATE

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let userViewModel = usersViewModel.createUserViewModel(forUserAt: indexPath)
        let userVC = UserViewController(viewModel: userViewModel)
        self.navigationController?.pushViewController(userVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let usersCount = usersViewModel.usersCount

        if indexPath.row == usersCount - 1 {
            if let searchBarText = usersView.searchBar.text, !searchBarText.isEmpty {
                let searchUsersTotalCount = usersViewModel.searchUsersTotalCount
                if searchUsersTotalCount > usersCount {
                    currentPage += 1
                    usersViewModel.getSearchUsersNextPage(userLoginName: searchBarText, page: currentPage)
                    return
                }
                return
            }
            
            let lastUserOnPage = usersViewModel.getLastUserOnPage()
            usersViewModel.getUsersNextPage(sinceUserId: lastUserOnPage.id)
        }
    }
}

// MARK: - SEARCH BAR DELEGATE

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if currentPage > 1 {
            currentPage = 1
        }

        if searchText.isEmpty {
            usersViewModel.getUsers()
            return
        }

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.usersViewModel.searchUsers(userLoginName: searchText)
        })
    }
}
