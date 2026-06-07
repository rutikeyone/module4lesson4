//
//  NetworkService.swift
//  module4lesson3
//
//  Created by Andrew on 30.05.2026.
//

import Foundation
import Alamofire

protocol NewsServiceProtocol {
    func fetchNews(_ searchQuery: String, completion: @escaping (Result<NewsResponse, Error>) -> Void)
    func fetchArticle(by id: String, completion: @escaping (Result<Article, Error>) -> Void)
}

nonisolated final class NewsService: NewsServiceProtocol {
    private let session: Session

    init(session: Session) {
        self.session = session
    }

    func fetchNews(_ searchQuery: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        session.request(NewsRouter.latest(query: searchQuery))
            .validate()
            .responseDecodable(of: NewsResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func fetchArticle(by id: String, completion: @escaping (Result<Article, Error>) -> Void) {
        session.request(NewsRouter.article(id: id))
            .validate()
            .responseDecodable(of: NewsResponse.self) { response in
                switch response.result {
                case .success(let data):
                    if let article = data.articles.first {
                        completion(.success(article))
                    } else {
                        completion(.failure(NewsServiceError.articleNotFound))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

enum NewsServiceError: Error {
    case articleNotFound
}
