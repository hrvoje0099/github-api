//
//  DateFormatter+Convert.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 24.11.2021.
//

import Foundation

extension DateFormatter {
    static let formatter: DateFormatter = {
        let df = DateFormatter()
        return df
    }()
    
    func convertDateFormat(inputDate: String) -> String {
        DateFormatter.formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let oldDate = DateFormatter.formatter.date(from: inputDate) else { return "" }
        
        DateFormatter.formatter.dateFormat = "dd.MM.yyyy."
        return DateFormatter.formatter.string(from: oldDate)
    }
}
