//
//  NewsFeedView.swift
//  module4lesson3
//
//  Created by Andrew on 30.05.2026.
//

import UIKit

final class NewsFeedView: UIView {

    private enum Section: Int, CaseIterable {
        case featured
        case list
    }

    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.backgroundPrimary
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 120
        view.showsVerticalScrollIndicator = false
        
        return view
    }()

    private var featured: Article?
    private var articles: [Article] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = AppColor.backgroundPrimary
        
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeaturedNewsCard.self, forCellReuseIdentifier: FeaturedNewsCard.reuseID)
        tableView.register(NewsItemCell.self, forCellReuseIdentifier: NewsItemCell.reuseID)

        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func showArticles(_ articles: [Article]) {
        featured = articles.first
        self.articles = Array(articles.dropFirst())
        
        tableView.reloadData()
    }
}

extension NewsFeedView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .featured:
            return featured == nil ? 0 : 1
        case .list:
            return articles.count
        case .none:
            return .zero
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .featured:
            return featuredCell(tableView, at: indexPath)
        case .list:
            return listCell(tableView, at: indexPath)
        case .none:
            return UITableViewCell()
        }
    }

    private func featuredCell(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FeaturedNewsCard.reuseID,
            for: indexPath
        ) as? FeaturedNewsCard else {
            return FeaturedNewsCard()
        }

        if let featured = self.featured {
            cell.configure(
                source: featured.source.name,
                title: featured.title,
                meta: NewsDateFormatter.string(from: featured.publishedAt),
                imageURL: URL(string: featured.urlToImage ?? "")
            )
        }

        return cell
    }

    private func listCell(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsItemCell.reuseID,
            for: indexPath
        ) as? NewsItemCell else {
            return UITableViewCell()
        }

        let article = articles[indexPath.row]
        
        cell.configure(
            source: article.source.name,
            title: article.title,
            description: article.description,
            time: NewsDateFormatter.string(from: article.publishedAt),
            imageURL: URL(string: article.urlToImage ?? "")
        )
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Section(rawValue: section) == .list && !articles.isEmpty ? Strings.News.sectionAll : nil
    }
}

extension NewsFeedView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
