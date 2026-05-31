//
//  NewsDateFormatter.swift
//  module4lesson3
//
//  Created by Andrew on 30.05.2026.
//

import Foundation

enum NewsDateFormatter {

    private static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    private static let relativeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale.current
        
        return formatter
    }()

    static func string(from publishedAt: String) -> String {
        guard let date = isoFormatter.date(from: publishedAt) else {
            return publishedAt
        }
        return relativeFormatter.localizedString(for: date, relativeTo: Date())
    }
}
