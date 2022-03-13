//
//  Repository.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 07.12.2021.
//

import Foundation

struct Repository {
    
    // MARK: - PROPERTIES
    
    private let apiClient: APIClient
    
    // MARK: - INIT
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    // MARK: - API FUNCTIONS
    
    func getUsers(completion: @escaping (Result<[Users], RequestError>) -> Void) {
        apiClient.getUsers(from: .getUsers) { result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUsersNextPage(sinceId: Int, completion: @escaping (Result<[Users], RequestError>) -> Void) {
        apiClient.getUsersNextPage(sinceId: sinceId, from: .getUsers) { result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchUsers(userLoginName: String, completion: @escaping (Result<SearchUsers, RequestError>) -> Void) {
        apiClient.searchUsers(userLoginName: userLoginName, from: .searchUsers) { result in
            switch result {
            case .success(let searchUsers):
                completion(.success(searchUsers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getSearchUsersNextPage(userLoginName: String, page: Int, completion: @escaping (Result<SearchUsers, RequestError>) -> Void) {
        apiClient.getSearchUsersNextPage(userLoginName: userLoginName, page: page, from: .searchUsers) { result in
            switch result {
            case .success(let searchUsers):
                completion(.success(searchUsers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUserRepos(userLoginName: String, completion: @escaping (Result<[Repo], RequestError>) -> Void) {
        apiClient.getUserRepos(userLoginName: userLoginName, from: .getUserRepos) { result in
            switch result {
            case .success(let userRepos):
                completion(.success(userRepos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUserReposNextPage(userLoginName: String, page: Int, completion: @escaping (Result<[Repo], RequestError>) -> Void) {
        apiClient.getUserReposNextPage(userLoginName: userLoginName, page: page, from: .getUserRepos) { result in
            switch result {
            case .success(let userRepos):
                completion(.success(userRepos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUserDetails(userLoginName: String, completion: @escaping (Result<User, RequestError>) -> Void) {
        apiClient.getUserDetails(userLoginName: userLoginName, from: .getTotalUserRepos) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
