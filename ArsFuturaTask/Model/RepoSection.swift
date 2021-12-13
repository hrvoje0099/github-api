//
//  RepoSection.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 23.11.2021.
//

import Foundation

protocol RepoSectionProtocol: CustomStringConvertible {
    var containsLabel: Bool { get }
    var isDataDetectorType: Bool  { get }
}

struct RepoSection {
    let options: [Options]
}

enum Options: Int, CaseIterable, RepoSectionProtocol {
    case repoName
    case description
    case createdDate
    case repoUrl
    case forks
    
    var description: String {
        switch self {
        case .repoName: return "Repo name:"
        case .description: return ""
        case .createdDate: return "Created at:"
        case .repoUrl: return "URL:"
        case .forks: return "Forks:"
        }
    }
    
    var containsLabel: Bool {
        switch self {
        case .repoName: return true
        case .description: return false
        case .createdDate: return true
        case .repoUrl: return true
        case .forks: return true
        }
    }
    
    var isDataDetectorType: Bool {
        switch self {
        case .repoName: return false
        case .description: return false
        case .createdDate: return false
        case .repoUrl: return true
        case .forks: return false
        }
    }
}
