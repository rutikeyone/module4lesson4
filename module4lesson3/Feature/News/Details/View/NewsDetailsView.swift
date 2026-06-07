//
//  NewsDetailsView.swift
//  module4lesson3
//
//  Created by Andrew on 02.06.2026.
//

import UIKit

enum NewsDetailsViewState {
    case idle
    case loading
    case loaded(Article)
    case failure(Error)
}

final class NewsDetailsView: UIView {
    
    var onRetry: (() -> Void)? {
        didSet { errorView.onRetry = onRetry }
    }

    var onOpenLink: ((URL) -> Void)?

    private lazy var contentView: NewsDetailsContentView = {
        let view = NewsDetailsContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        view.onOpenSource = { [weak self] url in
            self?.onOpenLink?(url)
        }

        return view
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(:coder) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = AppColor.backgroundPrimary
        
        setupContentView()
        setupErrorView()
        setupActivityIndicator()
    }

    private func setupContentView() {
        addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
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
    
    func render(_ state: NewsDetailsViewState) {
        switch state {
        case .idle:
            hideAll()
        case .loading:
            hideAll()
            activityIndicator.startAnimating()
        case .loaded(let article):
            hideAll()
            contentView.isHidden = false
            contentView.configure(makeConfiguration(from: article))
        case .failure(let error):
            hideAll()
            errorView.isHidden = false
            errorView.configure(error: error)
        }
    }

    private func hideAll() {
        errorView.isHidden = true
        contentView.isHidden = true
        activityIndicator.stopAnimating()
    }

    private func makeConfiguration(from article: Article) -> NewsDetailsContentView.Configuration {
        NewsDetailsContentView.Configuration(
            imageURL: article.imageUrl.flatMap(URL.init(string:)),
            category: nil,
            title: article.title,
            sourceName: article.sourceName,
            sourceIconURL: nil,
            date: NewsDateFormatter.string(from: article.pubDate),
            lede: article.description,
            link: article.link.flatMap(URL.init(string:))
        )
    }
}
