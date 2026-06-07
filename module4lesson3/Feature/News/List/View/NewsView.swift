//
//  NewsView.swift
//  module4lesson3
//
//  Created by Andrew on 30.05.2026.
//

import UIKit

enum NewsViewState {
    case idle
    case loading
    case loaded([Article])
    case failure(Error)
}

final class NewsView: UIView {

    var onRetry: (() -> Void)? {
        didSet { errorView.onRetry = onRetry }
    }

    var onArticleSelected: ((Article) -> Void)? {
        didSet { feedView.onArticleSelected = onArticleSelected }
    }

    private let feedView: NewsFeedView = {
        let view = NewsFeedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private let emptyView: NewsEmptyView = {
        let view = NewsEmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true

        return view
    }()

    private let errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true

        return view
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = AppColor.backgroundPrimary
        
        setupFeedView()
        setupEmptyView()
        setupErrorView()
        setupActivityIndicator()
    }

    private func setupFeedView() {
        addSubview(feedView)

        NSLayoutConstraint.activate([
            feedView.topAnchor.constraint(equalTo: topAnchor),
            feedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            feedView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupEmptyView() {
        addSubview(emptyView)

        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupErrorView() {
        addSubview(errorView)

        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupActivityIndicator() {
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func render(_ state: NewsViewState) {
        switch state {
        case .idle:
            hideAll()
            emptyView.isHidden = false
        case .loading:
            hideAll()
            activityIndicator.startAnimating()
        case .loaded(let articles):
            hideAll()
            feedView.isHidden = false
            feedView.showArticles(articles)
        case .failure(let error):
            hideAll()
            errorView.isHidden = false
            errorView.configure(error: error)
        }
    }

    private func hideAll() {
        feedView.isHidden = true
        emptyView.isHidden = true
        errorView.isHidden = true
        activityIndicator.stopAnimating()
    }
}
