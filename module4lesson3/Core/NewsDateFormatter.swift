//
//  NewsDateFormatter.swift
//  module4lesson3
//
//  Created by Andrew on 30.05.2026.
//

import Foundation

enum NewsDateFormatter {

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()

    private static let relativeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale.current
        return formatter
    }()

    static func string(from pubDate: String) -> String {
        guard let date = dateFormatter.date(from: pubDate) else {
            return pubDate
        }
        return relativeFormatter.localizedString(for: date, relativeTo: Date())
    }
}
