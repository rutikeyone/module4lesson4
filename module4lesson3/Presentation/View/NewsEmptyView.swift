//
//  NewsSearchEmptyView.swift
//  module4lesson3
//
//  Created by Andrew on 30.05.2026.
//

import UIKit

final class NewsEmptyView: UIView {

    private let iconView: UIImageView = {
        let view = UIImageView()

        let config = UIImage.SymbolConfiguration(pointSize: 56, weight: .light)
        view.image = UIImage(systemName: "magnifyingglass", withConfiguration: config)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = AppColor.textTertiary
        view.contentMode = .scaleAspectFit
        view.alpha = 0.55

        return view
    }()

    private let titleLabel: UILabel = {
        let view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFont.featuredTitle
        view.textColor = AppColor.textPrimary
        view.textAlignment = .center
        view.text = Strings.SearchEmpty.title

        return view
    }()

    private let descriptionLabel: UILabel = {
        let view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFont.count
        view.textColor = AppColor.textTertiary
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = Strings.SearchEmpty.description

        return view
    }()

    private let contentStack: UIStackView = {
        let view = UIStackView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = AppSpacing.xs

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
        
        setupContentStack()
    }

    private func setupContentStack() {
        contentStack.addArrangedSubview(iconView)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(descriptionLabel)
        contentStack.setCustomSpacing(AppSpacing.xl, after: iconView)

        addSubview(contentStack)

        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 56),
            iconView.heightAnchor.constraint(equalToConstant: 56),

            descriptionLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 260),

            contentStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: AppSpacing.xl + AppSpacing.s),
            contentStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -(AppSpacing.xl + AppSpacing.s)),
        ])
    }
}
