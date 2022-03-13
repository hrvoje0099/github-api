//
//  User.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 17.11.2021.
//

import Foundation

struct Users: Codable {
    let login: String
    let id: Int
    let avatarUrl: String
    let htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}
