//
//  Constants.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 17.11.2021.
//

import UIKit

enum Constants {
    static let baseEndPoint = "https://api.github.com"
    
    enum Colors {
        static let navigationBarColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        static let backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        static let htmlUrlColorHighAlpha = UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
        static let htmlUrlColorLowerAlpha = UIColor(red: 0, green: 0.48, blue: 1, alpha: 0.6)
        static let paynesColor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 1)
    }
}

enum UserAlert: String, Error {
    case noDataError = "Message for no data error..."
    case dataDecodingError = "Message for data decoding error..."
    case apiError = "Message for API error..."
    case invalidResponseError = "Message for invalid response error..."
}
