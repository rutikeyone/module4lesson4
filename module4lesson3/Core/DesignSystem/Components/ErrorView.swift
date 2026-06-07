//
//  ErrorView.swift
//  module4lesson3
//
//  Created by Andrew on 30.05.2026.
//

import UIKit

final class ErrorView: UIView {

    var onRetry: (() -> Void)?

    private let iconContainer: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.backgroundSurface
        view.layer.cornerRadius = AppRadius.extraLarge
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 16
        view.layer.shadowOffset = CGSize(width: 0, height: 4)

        return view
    }()

    private let iconView: UIImageView = {
        let view = UIImageView()

        let config = UIImage.SymbolConfiguration(pointSize: AppSize.errorIconGlyph, weight: .regular)
        view.image = UIImage(systemName: "exclamationmark.triangle", withConfiguration: config)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = AppColor.accentDestructive
        view.contentMode = .scaleAspectFit

        return view
    }()

    private let titleLabel: UILabel = {
        let view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFont.sectionTitle
        view.textColor = AppColor.textPrimary
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = Strings.Error.title

        return view
    }()

    private let descriptionLabel: UILabel = {
        let view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFont.callout
        view.textColor = AppColor.textTertiary
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = nil

        return view
    }()

    private let textStack: UIStackView = {
        let view = UIStackView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = AppSpacing.s

        return view
    }()

    private lazy var retryButton: PrimaryButton = {
        let view = PrimaryButton(title: Strings.Error.retry, image: UIImage(systemName: "arrow.clockwise"))

        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)

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

        setupIconContainer()
        setupTextStack()
        setupRetryButton()
    }

    private func setupIconContainer() {
        iconContainer.addSubview(iconView)
        addSubview(iconContainer)

        NSLayoutConstraint.activate([
            iconContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconContainer.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -AppSize.errorIconContainer),
            iconContainer.widthAnchor.constraint(equalToConstant: AppSize.errorIconContainer),
            iconContainer.heightAnchor.constraint(equalToConstant: AppSize.errorIconContainer),

            iconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
        ])
    }

    private func setupTextStack() {
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(descriptionLabel)
        addSubview(textStack)

        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: AppSpacing.xl),
            textStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            textStack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: AppSpacing.xl),
            textStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -AppSpacing.xl),

            descriptionLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
        ])
    }

    private func setupRetryButton() {
        addSubview(retryButton)

        NSLayoutConstraint.activate([
            retryButton.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: AppSpacing.xxl),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 280),
        ])
    }

    func configure(error: Error) {
        descriptionLabel.text = error.localizedDescription
    }

    @objc private func retryTapped() {
        onRetry?()
    }
}
