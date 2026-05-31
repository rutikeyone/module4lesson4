import UIKit
import SDWebImage

final class NewsItemCell: UITableViewCell {

    static let reuseID = "NewsItemCell"

    private var thumbnailWidth: NSLayoutConstraint!
    private var thumbnailLeading: NSLayoutConstraint!

    private let sourceLabel = SourceLabel(style: .list)

    private let titleLabel: UILabel = {
        let view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFont.newsTitle
        view.textColor = AppColor.textPrimary
        view.numberOfLines = 3

        return view
    }()

    private let descLabel: UILabel = {
        let view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFont.body2
        view.textColor = AppColor.textSecondary
        view.numberOfLines = 2

        return view
    }()

    private let timeLabel: UILabel = {
        let view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFont.caption
        view.textColor = AppColor.textTertiary

        return view
    }()

    private let thumbnail: UIImageView = {
        let view = UIImageView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = AppRadius.small
        view.backgroundColor = AppColor.backgroundFill

        return view
    }()

    private let textStack: UIStackView = {
        let view = UIStackView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = AppSpacing.xs

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
        backgroundColor = AppColor.backgroundSurface

        setupTextStack()
        setupThumbnail()
    }

    private func setupTextStack() {
        textStack.addArrangedSubview(sourceLabel)
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(descLabel)
        textStack.addArrangedSubview(timeLabel)
        textStack.setCustomSpacing(3, after: sourceLabel)

        contentView.addSubview(textStack)

        let topInset = AppSpacing.l - 2

        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
            textStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppSpacing.l),
            textStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -topInset),
        ])
    }

    private func setupThumbnail() {
        contentView.addSubview(thumbnail)

        let topInset = AppSpacing.l - 2

        thumbnailWidth = thumbnail.widthAnchor.constraint(equalToConstant: AppSize.thumbnail)
        thumbnailLeading = thumbnail.leadingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: AppSpacing.m)

        NSLayoutConstraint.activate([
            thumbnailLeading,
            thumbnail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppSpacing.l),
            thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
            thumbnail.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -topInset),
            thumbnailWidth,
            thumbnail.heightAnchor.constraint(equalToConstant: AppSize.thumbnail),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        thumbnail.sd_cancelCurrentImageLoad()
        thumbnail.image = nil
    }

    func configure(source: String, title: String, description: String?, time: String, imageURL: URL? = nil) {
        sourceLabel.configure(source: source)
        titleLabel.text = title
        descLabel.text = description
        descLabel.isHidden = (description?.isEmpty ?? true)
        timeLabel.text = time

        let hasImage = imageURL != nil
        thumbnail.isHidden = !hasImage
        thumbnailWidth.constant = hasImage ? AppSize.thumbnail : 0
        thumbnailLeading.constant = hasImage ? AppSpacing.m : 0
        thumbnail.sd_setImage(with: imageURL)
    }
}
