//
//  NewsDetailsContentView.swift
//  module4lesson3
//
//  Created by Andrew on 07.06.2026.
//

import UIKit
import SDWebImage

final class NewsDetailsContentView: UIView {

    struct Configuration {
        let imageURL: URL?
        let category: String?
        let title: String
        let sourceName: String?
        let sourceIconURL: URL?
        let date: String
        let lede: String?
        let link: URL?
    }

    var onOpenSource: ((URL) -> Void)?

    private var link: URL?

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = true
        view.contentInsetAdjustmentBehavior = .never
        view.alwaysBounceVertical = true

        if #available(iOS 26.0, *) {
            view.topEdgeEffect.isHidden = true
        }

        return view
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = AppColor.backgroundFill
        
        return view
    }()

    private let articleStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        
        return view
    }()

    private let eyebrowLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.eyebrow
        view.textColor = AppColor.accent
        view.numberOfLines = 1
        
        return view
    }()

    private let headlineLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.articleTitle
        view.textColor = AppColor.textPrimary
        view.numberOfLines = 0
        
        return view
    }()

    private let ledeLabel: UILabel = {
        let view = UILabel()
        view.font = AppFont.lede
        view.textColor = AppColor.textPrimary
        view.numberOfLines = 0
        
        return view
    }()

    private let sourceIconView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = AppRadius.small
        view.backgroundColor = AppColor.backgroundFill
        view.tintColor = AppColor.textTertiary
        
        return view
    }()

    private let sourceNameLabel: UILabel = {
        let view = UILabel()
        
        view.font = AppFont.newsTitle
        view.textColor = AppColor.textPrimary
        view.numberOfLines = 1
        
        return view
    }()

    private let sourceDateLabel: UILabel = {
        let view = UILabel()
        
        view.font = AppFont.footnote
        view.textColor = AppColor.textSecondary
        view.numberOfLines = 1
        
        return view
    }()

    private lazy var readButton: UIButton = {
        var config = UIButton.Configuration.gray()
        
        config.title = Strings.NewsDetails.read
        config.baseForegroundColor = AppColor.accent
        config.background.backgroundColor = AppColor.backgroundFill
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(
            top: AppSpacing.xs, leading: AppSpacing.l,
            bottom: AppSpacing.xs, trailing: AppSpacing.l
        )
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var updated = attributes
            updated.font = AppFont.button
        
            return updated
        }

        let view = UIButton(configuration: config)
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.addTarget(self, action: #selector(openSource), for: .touchUpInside)
        
        return view
    }()

    private let separator: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.separatorOpaque
        
        return view
    }()

    private let noticeTitleLabel: UILabel = {
        let view = UILabel()
        
        view.font = AppFont.newsTitle
        view.textColor = AppColor.textPrimary
        view.text = Strings.NewsDetails.noticeTitle
        view.numberOfLines = 0

        return view
    }()

    private let noticeSubtitleLabel: UILabel = {
        let view = UILabel()
        
        view.font = AppFont.footnote
        view.textColor = AppColor.textSecondary
        view.text = Strings.NewsDetails.noticeSubtitle
        view.numberOfLines = 0
        
        return view
    }()

    private lazy var sourceButton: PrimaryButton = {
        let view = PrimaryButton(
            title: Strings.NewsDetails.sourceButton,
            image: UIImage(systemName: "arrow.up.right.square")
        )
        view.addTarget(self, action: #selector(openSource), for: .touchUpInside)
        
        return view
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setupViews() {
        backgroundColor = AppColor.backgroundPrimary

        setupScroll()
        setupImageView()
        setupArticleStack()
    }

    private func setupScroll() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
        ])
    }

    private func setupImageView() {
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(
                equalTo: imageView.widthAnchor,
                multiplier: AppSize.heroAspectRatio
            ),
        ])
    }

    private func setupArticleStack() {
        let sourceRow = makeSourceRow()
        let notice = makeNotice()

        [eyebrowLabel, headlineLabel, sourceRow, separator, ledeLabel,
         notice, sourceButton]
            .forEach { articleStack.addArrangedSubview($0) }

        articleStack.setCustomSpacing(AppSpacing.xs, after: eyebrowLabel)
        articleStack.setCustomSpacing(AppSpacing.l, after: headlineLabel)
        articleStack.setCustomSpacing(AppSpacing.l, after: sourceRow)
        articleStack.setCustomSpacing(AppSpacing.l, after: separator)
        articleStack.setCustomSpacing(AppSpacing.xl, after: ledeLabel)
        articleStack.setCustomSpacing(AppSpacing.xl, after: notice)

        contentView.addSubview(articleStack)

        NSLayoutConstraint.activate([
            articleStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: AppSpacing.xl),
            articleStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppSpacing.xl),
            articleStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppSpacing.xl),
            articleStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppSpacing.xxl),

            separator.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

    private func makeSourceRow() -> UIView {
        let info = UIStackView(arrangedSubviews: [sourceNameLabel, sourceDateLabel])
        info.axis = .vertical
        info.spacing = 1
        info.setContentHuggingPriority(.defaultLow, for: .horizontal)

        let row = UIStackView(arrangedSubviews: [sourceIconView, info, readButton])
        row.axis = .horizontal
        row.alignment = .center
        row.spacing = AppSpacing.s

        NSLayoutConstraint.activate([
            sourceIconView.widthAnchor.constraint(equalToConstant: AppSize.sourceAvatar),
            sourceIconView.heightAnchor.constraint(equalToConstant: AppSize.sourceAvatar),
        ])

        return row
    }

    private func makeNotice() -> UIView {
        let container = UIView()
        container.backgroundColor = AppColor.backgroundFill
        container.layer.cornerRadius = AppRadius.medium
        container.layer.cornerCurve = .continuous

        let iconContainer = UIView()
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.backgroundColor = AppColor.backgroundSurface
        iconContainer.layer.cornerRadius = AppRadius.small
        iconContainer.layer.cornerCurve = .continuous

        let icon = UIImageView(image: UIImage(systemName: "lock.fill"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = AppColor.textSecondary
        icon.contentMode = .scaleAspectFit

        let textStack = UIStackView(arrangedSubviews: [noticeTitleLabel, noticeSubtitleLabel])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.spacing = AppSpacing.xs / 2

        iconContainer.addSubview(icon)
        container.addSubview(iconContainer)
        container.addSubview(textStack)

        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: AppSpacing.l),
            iconContainer.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: AppSize.noticeIcon),
            iconContainer.heightAnchor.constraint(equalToConstant: AppSize.noticeIcon),

            icon.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),

            textStack.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: AppSpacing.m),
            textStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -AppSpacing.l),
            textStack.topAnchor.constraint(equalTo: container.topAnchor, constant: AppSpacing.l),
            textStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -AppSpacing.l),
        ])

        return container
    }

    func configure(_ configuration: Configuration) {
        link = configuration.link

        imageView.sd_setImage(with: configuration.imageURL)

        eyebrowLabel.text = configuration.category?.uppercased()
        eyebrowLabel.isHidden = (configuration.category?.isEmpty ?? true)

        headlineLabel.text = configuration.title

        sourceNameLabel.text = configuration.sourceName
        sourceDateLabel.text = configuration.date

        if let iconURL = configuration.sourceIconURL {
            sourceIconView.sd_setImage(with: iconURL)
        }

        ledeLabel.text = configuration.lede
        ledeLabel.isHidden = (configuration.lede?.isEmpty ?? true)

        let hasLink = configuration.link != nil
        readButton.isHidden = !hasLink
        sourceButton.isHidden = !hasLink

        scrollView.setContentOffset(.zero, animated: false)
    }

    @objc private func openSource() {
        guard let link else { return }
        onOpenSource?(link)
    }
}
