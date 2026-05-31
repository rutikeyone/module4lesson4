//
//  NetworkService.swift
//  module4lesson3
//
//  Created by Andrew on 30.05.2026.
//

import Foundation
import Alamofire

protocol NewsServiceProtocol {
    func fetchNews(_ searchQuary: String, completion: @escaping (Result<NewsResponse, Error>) -> Void)
}

nonisolated final class NewsService: NewsServiceProtocol {
    func fetchNews(_ searchQuary: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "q": searchQuary,
            "sortBy": "publishedAt",
            "apiKey": "8ebcdaa0139a47d1a7e1e77ad52a2b0a",
            "pageSize": 20,
        ]
        
        AF.request("https://newsapi.org/v2/everything", parameters: parameters)
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
}
