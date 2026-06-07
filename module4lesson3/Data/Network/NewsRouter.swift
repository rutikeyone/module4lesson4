//
//  NewsRouter.swift
//  module4lesson3

import Foundation
import Alamofire

nonisolated enum NewsRouter: URLRequestConvertible {
    case latest(query: String, language: String = "ru")
    case article(id: String)

    private var method: HTTPMethod { .get }

    private var path: String {
        switch self {
        case .latest, .article:
            return "latest"
        }
    }

    private var queryParameters: Parameters {
        switch self {
        case let .latest(query, language):
            return ["q": query, "language": language]
        case let .article(id):
            return ["id": id]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = AppEnvironment.apiBaseURL.appendingPathComponent(path)
        let request = try URLRequest(url: url, method: method)
        return try URLEncoding.default.encode(request, with: queryParameters)
    }
}
