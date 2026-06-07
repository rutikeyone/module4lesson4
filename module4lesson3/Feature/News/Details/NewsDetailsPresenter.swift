//
//  NewsDetailsPresenter.swift
//  module4lesson3
//
//  Created by Andrew on 01.06.2026.
//

import Foundation
import FactoryKit

protocol NewsDetailsPresenterProtocol: AnyObject {
    var articleId: String { get }
    
    func viewDidLoad()

    func retry()
}

final class NewsDetailsPresenter: NewsDetailsPresenterProtocol {
    let articleId: String
    
    weak var view: NewsDetailsViewProtocol?
    
    @Injected(\.newsService) private var newsService: NewsServiceProtocol

    private var state: NewsDetailsViewState = .idle {
        didSet { handleStateChange() }
    }
    
    init(articleId: String) {
        self.articleId = articleId
        self.newsService = newsService
    }
    
    func viewDidLoad() {
        loadData()
    }
    
    private func loadData()  {
        state = .loading
        
        newsService.fetchArticle(by: articleId) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                state = .loaded(data)
            case .failure(let error):
                state = .failure(error)
            }
        }
    }
    
    private func handleStateChange() {
        view?.render(state)
    }
    
    func retry() {
        loadData()
    }
}
