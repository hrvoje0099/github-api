//
//  UsersViewModel.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 07.12.2021.
//

import Foundation

protocol UsersViewModelProtocol: BaseViewModelProtocol {
    var usersCount: Int { get }
    var searchUsersTotalCount: Int { get }
    
    func getUsers()
    func getUserCellModel(at indexPath: IndexPath) -> Users
    func getLastUserOnPage() -> Users
    func getUsersNextPage(sinceUserId: Int)
    func searchUsers(userLoginName: String)
    func getSearchUsersNextPage(userLoginName: String, page: Int)
    func createUserViewModel(forUserAt indexPath: IndexPath) -> UserViewModel
}

final class UsersViewModel: BaseViewModel, UsersViewModelProtocol {
    
    // MARK: - PROTOCOL PROPERTIES
    
    var usersCount: Int {
        return users.count
    }
    
    var searchUsersTotalCount: Int = 0
    
    // MARK: - PRIVATE PROPERTIES
    
    private let repository: Repository
    
    private var users = [Users]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    // MARK: - INIT
    
    init(repository: Repository = Repository()) {
        self.repository = repository
    }
    
    // MARK: - PROTOCOL METHODS
    
    func getUsers() {
        self.isLoading = true
        
        repository.getUsers { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                self?.processError(error: error)
            }
        }
    }
    
    func getUserCellModel(at indexPath: IndexPath) -> Users {
        return users[indexPath.row]
    }
    
    func getLastUserOnPage() -> Users {
        return users[users.count - 1]
    }
    
    func getUsersNextPage(sinceUserId: Int) {
        self.isLoading = true
        
        repository.getUsersNextPage(sinceId: sinceUserId) { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let users):
                if !users.isEmpty { self?.users += users }
            case .failure(let error):
                self?.processError(error: error)
            }
        }
    }
    
    func searchUsers(userLoginName: String) {
        self.isLoading = true
        
        repository.searchUsers(userLoginName: userLoginName) { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let searchUsers):
                self?.users = searchUsers.items
                self?.searchUsersTotalCount = searchUsers.totalCount
            case .failure(let error):
                self?.processError(error: error)
            }
        }
    }
    
    func getSearchUsersNextPage(userLoginName: String, page: Int) {
        self.isLoading = true
        
        repository.getSearchUsersNextPage(userLoginName: userLoginName, page: page) { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let searchUsers):
                self?.users += searchUsers.items
            case .failure(let error):
                self?.processError(error: error)
            }
        }
    }
    
    func createUserViewModel(forUserAt indexPath: IndexPath) -> UserViewModel {
        let user = users[indexPath.row]
        return UserViewModel(repository, user)
    }
}
