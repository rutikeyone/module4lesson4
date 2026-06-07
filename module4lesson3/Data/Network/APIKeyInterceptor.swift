//
//  APIKeyInterceptor.swift
//  module4lesson3


import Foundation
import Alamofire

nonisolated struct APIKeyInterceptor: RequestInterceptor {
    private let apiKey: String

    init(apiKey: String = AppEnvironment.apiKey) {
        self.apiKey = apiKey
    }

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest

        guard
            let url = request.url,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            completion(.success(request))
            return
        }

        var items = components.queryItems ?? []
        items.append(URLQueryItem(name: "apikey", value: apiKey))
        components.queryItems = items
        request.url = components.url

        completion(.success(request))
    }
}
