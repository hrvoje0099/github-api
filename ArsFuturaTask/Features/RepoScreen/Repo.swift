//
//  Repo.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 21.11.2021.
//

import Foundation

struct Repo: Codable {
    let name: String
    let htmlUrl: String
    let description: String?
    let createdAt: String
    let forks: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case htmlUrl = "html_url"
        case description
        case createdAt = "created_at"
        case forks
    }
}
