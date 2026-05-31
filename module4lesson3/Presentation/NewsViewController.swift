//
//  ViewController.swift
//  module4lesson3
//
//  Created by Andrew on 29.05.2026.
//

import UIKit
import FactoryKit

protocol NewsViewProtocol: AnyObject {
    func render(_ state: NewsViewState)
}

class NewsViewController: UIViewController {

    private let presenter: NewsPresenterProtocol
    
    private let newsView: NewsView = {
        let view = NewsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let searchController: UISearchController
    
    init(presenter: NewsPresenterProtocol) {
        self.presenter = presenter
        self.searchController = UISearchController()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("coder: has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = AppColor.backgroundPrimary
        title = Strings.News.title
        
        setupSearchController()
        setupNewsView()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = Strings.News.searchPlaceholder
        
        navigationItem.searchController = searchController
    }
    
    private func setupNewsView() {
        newsView.onRetry = { [weak self] in
            self?.presenter.retry()
        }
        view.addSubview(newsView)

        NSLayoutConstraint.activate([
            newsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension NewsViewController: NewsViewProtocol {
    func render(_ state: NewsViewState) {
        UIView.animate(withDuration: 0.2) {
            self.newsView.render(state)
        }
    }
}

extension NewsViewController {
    static func create() -> NewsViewController {
        let presenter = NewsPresenter()

        let viewController = NewsViewController(presenter: presenter)
        presenter.view = viewController

        return viewController
    }
}

extension NewsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        presenter.search(query)
    }
}
