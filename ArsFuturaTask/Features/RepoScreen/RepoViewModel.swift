//
//  RepoViewModel.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 23.11.2021.
//

import Foundation

protocol RepoViewModelProtocol {
    func getUserData() -> Users
    func getRepoData(for option: Options) -> String
    func getRepoName() -> String
    func getNumberOfOptions(inSection section: Int) -> Int
    func getOptionForSection(at indexPath: IndexPath) -> Options
    func getSectionCount() -> Int
}

struct RepoViewModel: RepoViewModelProtocol {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let user: Users
    private let repo: Repo
    
    // MARK: - INIT
    
    init(_ user: Users, _ repo: Repo) {
        self.user = user
        self.repo = repo
    }
    
    // MARK: - PROTOCOL METHODS
    
    func getUserData() -> Users {
        return user
    }
    
    func getRepoData(for option: Options) -> String {
        switch option {
        case .repoName:
            return repo.name
        case .description:
            return repo.description ?? ""
        case .createdDate:
            return DateFormatter.formatter.convertDateFormat(inputDate: repo.createdAt)
        case .repoUrl:
            return "\(repo.htmlUrl)"
        case .forks:
            return String(repo.forks)
        }
    }
    
    func getRepoName() -> String {
        return repo.name
    }
    
    func getNumberOfOptions(inSection section: Int) -> Int {
        return getSections()[section].options.count
    }
    
    func getOptionForSection(at indexPath: IndexPath) -> Options {
        return getSections()[indexPath.section].options[indexPath.row]
    }
    
    func getSectionCount() -> Int {
        return getSections().count
    }
    
    // MARK: - PRIVATE METHODS
    
    private func getSections() -> [RepoSection] {
        let sections: [RepoSection] = [
            RepoSection(options: [.repoName, .description]),
            RepoSection(options: [.createdDate, .repoUrl, .forks])
        ]
        return sections
    }
}
