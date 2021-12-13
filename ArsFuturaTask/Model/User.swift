//
//  User.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 12.12.2021..
//

import Foundation

struct User: Codable {
    let publicRepos: Int
    
    enum CodingKeys: String, CodingKey {
        case publicRepos = "public_repos"
    }
}
