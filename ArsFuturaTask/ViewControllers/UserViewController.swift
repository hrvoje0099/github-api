//
//  UserViewController.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 21.11.2021.
//

import UIKit

final class UserViewController: UIViewController {
    
    // MARK: - PROPERTIES
     
    private lazy var userView: UserView = {
        let userView = UserView()
        userView.reposTableView.delegate = self
        userView.reposTableView.dataSource = self
        
        let user = userViewModel.getUserData()
        userView.userInfoHeader.avatarImageView.loadImage(at: user.avatarUrl)
        userView.userInfoHeader.loginNameLabel.text = user.login
        userView.userInfoHeader.htmlUrlTextView.text = user.htmlUrl
        
        return userView
    }()
    
    private var userViewModel: UserViewModelProtocol
    private var currentPage = 1
    
    // MARK: - INIT
    
    init(viewModel: UserViewModelProtocol) {
        self.userViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = userView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        initViewModelBinding()
        getData()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupNavigation() {
        extendedLayoutIncludesOpaqueBars = true
        title = "User"
        navigationController?.restoreHairline()
    }
    
    private func initViewModelBinding() {
        userViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.userView.reposTableView.reloadData()
            }
        }
        
        userViewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.userViewModel.isLoading ?? false
                if isLoading {
                    self?.userView.activityIndicator.startAnimating()
                } else {
                    self?.userView.activityIndicator.stopAnimating()
                }
            }
        }
        
        userViewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.userViewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
    }
    
    private func getData() {
        userViewModel.getUserRepos()
        userViewModel.getUserDetails()
    }
}

// MARK: - TABLE VIEW DATA SOURCE

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.userReposCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.RepoCellReuseIdentifier, for: indexPath) as? RepoCell else { return UITableViewCell() }

        let repo = userViewModel.getRepoCellModel(at: indexPath)
        cell.loginNameLabel.text = repo.name
        cell.createdAtLabel.text = "Created at: \(DateFormatter.formatter.convertDateFormat(inputDate: repo.createdAt))"
        cell.descriptionLabel.text = repo.description

        return cell
    }
}

// MARK: - TABLE VIEW DELEGATE

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Constants.Colors.backgroundColor
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Repo list"
        title.font = .systemFont(ofSize: 12)
        title.textColor = .secondaryLabel
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.topAnchor),
            title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            title.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -7)
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let reposCount = userViewModel.userReposCount
        let totalUserReposCount = userViewModel.getTotalUserReposCount()
        
        if indexPath.row == reposCount - 1 && reposCount < totalUserReposCount {
            currentPage += 1
            userViewModel.getUserReposNextPage(currentPage)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let repoViewModel = userViewModel.createRepoViewModel(forRepoAt: indexPath)
        let repoVC = RepoViewController(viewModel: repoViewModel)
        self.navigationController?.pushViewController(repoVC, animated: true)
    }
}
