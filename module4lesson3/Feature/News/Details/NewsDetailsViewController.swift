//
//  NewsDetailsViewController.swift
//  module4lesson3
//
//  Created by Andrew on 01.06.2026.
//

import UIKit
import FactoryKit

protocol NewsDetailsViewProtocol: AnyObject {
    func render(_ state: NewsDetailsViewState)
}

final class NewsDetailsViewController: UIViewController {
    
    private let presenter: NewsDetailsPresenterProtocol
    
    private lazy var newsDetailsView: NewsDetailsView = {
        let view = NewsDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(presenter: NewsDetailsPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(:coder) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter.viewDidLoad()
    
    }
    
    private func setupViews() {
        view.backgroundColor = AppColor.backgroundPrimary

        setupNewsDetailsView()
    }
    
    private func setupNewsDetailsView() {
        newsDetailsView.onRetry = { [weak self] in
            guard let self else { return }

            presenter.retry()
        }

        newsDetailsView.onOpenLink = { url in
            UIApplication.shared.open(url)
        }

        view.addSubview(newsDetailsView)
        
        NSLayoutConstraint.activate([
            newsDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            newsDetailsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsDetailsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension NewsDetailsViewController {
    static func create(_ articleId: String) -> NewsDetailsViewController {
        let presenter = NewsDetailsPresenter(articleId: articleId)
        let viewController = NewsDetailsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

extension NewsDetailsViewController: NewsDetailsViewProtocol {
    func render(_ state: NewsDetailsViewState) {
        newsDetailsView.render(state)
    }
}
