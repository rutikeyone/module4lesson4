//
//  AppEnvironment.swift
//  module4lesson3

import Foundation

nonisolated enum AppEnvironment {
    static let apiBaseURL = URL(string: "https://newsdata.io/api/1")!

    static var apiKey: String {
        guard
            let key = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String,
            !key.isEmpty
        else {
            fatalError("APIKey не найден. Проверь Secrets.xcconfig и ключ APIKey в Info.plist.")
        }
        return key
    }
}
