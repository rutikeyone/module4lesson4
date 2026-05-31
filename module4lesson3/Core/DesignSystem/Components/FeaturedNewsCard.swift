import UIKit
import SDWebImage

final class FeaturedNewsCard: UITableViewCell {

    static let reuseID = "FeaturedNewsCard"

    private let container: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.backgroundSurface
        view.layer.cornerRadius = AppRadius.medium
        view.clipsToBounds = true

        return view
    }()

    private let newsImageView: UIImageView = {
        let view = UIImageView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = AppColor.backgroundFill

        return view
    }()

    private let sourceLabel = SourceLabel(style: .featured)

    private let titleLabel: UILabel = {
        let view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFont.featuredTitle
        view.textColor = AppColor.textPrimary
        view.numberOfLines = 3

        return view
    }()

    private let metaLabel: UILabel = {
        let view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFont.footnote
        view.textColor = AppColor.textTertiary

        return view
    }()

    private let textStack: UIStackView = {
        let view = UIStackView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = AppSpacing.s

        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none

        setupContainer()
        setupNewsImageView()
        setupTextStack()
    }

    private func setupContainer() {
        contentView.addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppSpacing.xl),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppSpacing.xl),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppSpacing.s),
        ])
    }

    private func setupNewsImageView() {
        container.addSubview(newsImageView)

        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: container.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: AppSize.featuredImageHeight),
        ])
    }

    private func setupTextStack() {
        textStack.addArrangedSubview(sourceLabel)
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(metaLabel)
        textStack.setCustomSpacing(6, after: sourceLabel)

        container.addSubview(textStack)

        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: AppSpacing.l - 2),
            textStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: AppSpacing.l),
            textStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -AppSpacing.l),
            textStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -AppSpacing.l),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        newsImageView.sd_cancelCurrentImageLoad()
        newsImageView.image = nil
    }

    func configure(source: String, title: String, meta: String, imageURL: URL? = nil) {
        sourceLabel.configure(source: source)
        titleLabel.text = title
        metaLabel.text = meta
        newsImageView.sd_setImage(with: imageURL)
    }
}
