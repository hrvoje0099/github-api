//
//  APIClient.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 07.12.2021.
//

import Foundation

enum RequestError: String, Error {
    case noData
    case dataDecodingError
    case apiError
    case invalidResponse
}

protocol APIClientProtocol {
    func fetchFromAPI<T: Codable>(_ type: GitHubApiMethods, decode: @escaping (Codable) -> T?, complete: @escaping (Result<T, RequestError>) -> ())
}

struct APIClient: APIClientProtocol {
    
    func getUsers(from type: GitHubApiMethods, completion: @escaping (Result<[Users], RequestError>) -> Void) {
        fetchFromAPI(type, decode: { json -> [Users]? in
            guard let result = json as? [Users] else { return  nil }
            return result
        }, complete: completion)
    }
    
    func getUsersNextPage(sinceId: Int, from type: GitHubApiMethods, completion: @escaping (Result<[Users], RequestError>) -> Void) {
        var mutableType = type
        mutableType.urlComponents.queryItems = [
            URLQueryItem(name: "since", value: String(sinceId))
        ]
        
        fetchFromAPI(mutableType, decode: { json -> [Users]? in
            guard let result = json as? [Users] else { return  nil }
            return result
        }, complete: completion)
    }
    
    func searchUsers(userLoginName: String, from type: GitHubApiMethods, completion: @escaping (Result<SearchUsers, RequestError>) -> Void) {
        var mutableType = type
        mutableType.urlComponents.queryItems = [
            URLQueryItem(name: "q", value: userLoginName)
        ]
        
        fetchFromAPI(mutableType, decode: { json -> SearchUsers? in
            guard let result = json as? SearchUsers else { return  nil }
            return result
        }, complete: completion)
    }
    
    func getSearchUsersNextPage(userLoginName: String, page: Int, from type: GitHubApiMethods, completion: @escaping (Result<SearchUsers, RequestError>) -> Void) {
        var mutableType = type
        mutableType.urlComponents.queryItems = [
            URLQueryItem(name: "q", value: userLoginName),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        fetchFromAPI(mutableType, decode: { json -> SearchUsers? in
            guard let result = json as? SearchUsers else { return  nil }
            return result
        }, complete: completion)
    }
    
    func getUserRepos(userLoginName: String, from type: GitHubApiMethods, completion: @escaping (Result<[Repo], RequestError>) -> Void) {
        var mutableType = type
        mutableType.path = userLoginName
        mutableType.urlComponents.queryItems = [
            URLQueryItem(name: "page", value: String(1)) // when we enter in user page, always load first page of repos
        ]
        
        fetchFromAPI(mutableType, decode: { json -> [Repo]? in
            guard let result = json as? [Repo] else { return  nil }
            return result
        }, complete: completion)
    }
    
    func getUserReposNextPage(userLoginName: String, page: Int, from type: GitHubApiMethods, completion: @escaping (Result<[Repo], RequestError>) -> Void) {
        var mutableType = type
        mutableType.path = userLoginName
        mutableType.urlComponents.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        
        fetchFromAPI(mutableType, decode: { json -> [Repo]? in
            guard let result = json as? [Repo] else { return  nil }
            return result
        }, complete: completion)
    }
    
    func getUserDetails(userLoginName: String, from type: GitHubApiMethods, completion: @escaping (Result<User, RequestError>) -> Void) {
        var mutableType = type
        mutableType.path = userLoginName
        
        fetchFromAPI(mutableType, decode: { json -> User? in
            guard let result = json as? User else { return  nil }
            return result
        }, complete: completion)
    }
}

extension APIClientProtocol {
    
    func fetchFromAPI<T: Codable>(_ type: GitHubApiMethods, decode: @escaping (Codable) -> T?, complete completion: @escaping (Result<T, RequestError>) -> Void) {
        
        URLSession.shared.dataTask(with: type.request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.apiError))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, !(200...299).contains(statusCode) {
                print("Status code: \(statusCode)")
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let decodedValues = try JSONDecoder().decode(T.self, from: data)
//                print(decodedValues)
                completion(.success(decodedValues))
            } catch  {
                completion(.failure(.dataDecodingError))
            }
        }.resume()
    }
    
}
