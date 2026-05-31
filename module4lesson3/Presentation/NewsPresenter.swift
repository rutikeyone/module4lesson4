//
//  NewsPresenter.swift
//  module4lesson3
//
//  Created by Andrew on 30.05.2026.
//

import Foundation
import Combine
import FactoryKit

protocol NewsPresenterProtocol: AnyObject {
    func search(_ searchQuery: String)
    func retry()
}

final class NewsPresenter: NewsPresenterProtocol {
    @Injected(\.newsService) private var newsService: NewsServiceProtocol

    private var state: NewsViewState = .idle {
        didSet { handleStateChange() }
    }

    private let searchSubject = CurrentValueSubject<String, Never>("")
    private var cancellables = Set<AnyCancellable>()

    weak var view: NewsViewProtocol? {
        didSet {
            guard view != nil else { return }
            bindSearch()
        }
    }

    private func loadData(_ searchQuery: String) {
        state = .loading

        newsService.fetchNews(searchQuery) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let data):
                state = .loaded(data.articles)
            case .failure(let error):
                state = .failure(error)
            }
        }
    }

    private func handleStateChange() {
        view?.render(state)
    }

    private func bindSearch() {
        searchSubject
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                if query.isEmpty {
                    self?.state = .idle
                } else {
                    self?.loadData(query)
                }
            }
            .store(in: &cancellables)
    }

    func search(_ searchQuery: String) {
        searchSubject.send(searchQuery)
    }

    func retry() {
        loadData(searchSubject.value)
    }
}
