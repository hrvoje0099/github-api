//
//  SearchUsers.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 21.11.2021.
//

import Foundation

struct SearchUsers: Codable {
    let totalCount: Int
    let items: [Users]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
