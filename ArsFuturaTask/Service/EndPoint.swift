//
//  EndPoint.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 07.12.2021.
//

import Foundation

protocol Endpoint {
    var path: String { get set }
    var urlComponents: URLComponents { get set }
}

extension Endpoint {
    var request: URLRequest {
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)
        
        // add your GitHub token to have more API calls
        // urlRequest.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
}

enum GitHubApiMethods {
    case getUsers
    case searchUsers
    case getUserRepos
    case getTotalUserRepos
}

extension GitHubApiMethods: Endpoint {
    private static var _urlComponents = URLComponents(string: Constants.baseEndPoint)!
    private static var _path = ""
    
    var urlComponents: URLComponents {
        get {
            GitHubApiMethods._urlComponents.path = path
            return GitHubApiMethods._urlComponents
        }
        set {
            GitHubApiMethods._urlComponents = newValue
        }
    }
    
    var path: String {
        get {
            switch self {
            case .getUsers: return "/users"
            case .searchUsers: return "/search/users"
            case .getUserRepos: return GitHubApiMethods._path
            case .getTotalUserRepos: return GitHubApiMethods._path
            }
        }
        set {
            switch self {
            case .getUsers: break
            case .searchUsers: break
            case .getUserRepos:
                GitHubApiMethods._path = "/users/\(newValue)/repos"
            case .getTotalUserRepos:
                GitHubApiMethods._path = "/users/\(newValue)"
            }
        }
    }
}
