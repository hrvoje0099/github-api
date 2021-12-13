//
//  UserViewModel.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 07.12.2021.
//

import Foundation

protocol UserViewModelProtocol: BaseViewModelProtocol {
    var userReposCount: Int { get }
    
    func getUserRepos()
    func getUserReposNextPage(_ page: Int)
    func getUserData() -> Users
    func getRepoCellModel(at indexPath: IndexPath) -> Repo
    func createRepoViewModel(forRepoAt indexPath: IndexPath) -> RepoViewModel
    func getUserDetails()
    func getTotalUserReposCount() -> Int
}

final class UserViewModel: BaseViewModel, UserViewModelProtocol {
    
    // MARK: - PROTOCOL PROPERTIES
    
    var userReposCount: Int {
        return repos.count
    }
    
    // MARK: - PRIVATE PROPERTIES
    
    private var userDetails = User(publicRepos: 0)
    
    private let repository: Repository
    private var user: Users
    
    private var repos = [Repo]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    // MARK: - INIT
    
    init(_ repository: Repository, _ user: Users) {
        self.repository = repository
        self.user = user
    }
    
    // MARK: - PROTOCOL METHODS
    
    func getUserRepos() {
        self.isLoading = true
        
        repository.getUserRepos(userLoginName: user.login) { [weak self] result in
            self?.isLoading = false
            
            switch result{
            case .success(let repos):
                self?.repos = repos
            case .failure(let error):
                self?.processError(error: error)
            }
        }
    }
    
    func getUserReposNextPage(_ page: Int) {
        self.isLoading = true
        
        repository.getUserReposNextPage(userLoginName: user.login, page: page) { [weak self] result in
            self?.isLoading = false
            
            switch result{
            case .success(let repos):
                if !repos.isEmpty { self?.repos += repos }
            case .failure(let error):
                self?.processError(error: error)
            }
        }
    }
    
    func getUserData() -> Users {
        return user
    }
    
    func getRepoCellModel(at indexPath: IndexPath) -> Repo {
        return repos[indexPath.row]
    }
    
    func createRepoViewModel(forRepoAt indexPath: IndexPath) -> RepoViewModel {
        let repo = repos[indexPath.row]
        return RepoViewModel(user, repo)
    }
    
    func getUserDetails() {
        repository.getUserDetails(userLoginName: user.login) { [weak self] result in
            switch result{
            case .success(let user):
                self?.userDetails = user
            case .failure(let error):
                self?.processError(error: error)
            }
        }
    }
    
    func getTotalUserReposCount() -> Int {
        return userDetails.publicRepos
    }
}
