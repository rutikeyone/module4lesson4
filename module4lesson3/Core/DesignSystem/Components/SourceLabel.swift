import UIKit

final class SourceLabel: UIView {

    enum Style {
        case featured
        case list
    }

    private let dot: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.accentDestructive
        view.layer.cornerRadius = AppSize.liveDot / 2

        return view
    }()

    private let titleLabel: UILabel = {
        let view = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFont.caption

        return view
    }()

    private let stack: UIStackView = {
        let view = UIStackView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = AppSpacing.xs

        return view
    }()

    init(style: Style) {
        super.init(frame: .zero)
        
        setupViews(style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews(style: Style) {
        switch style {
        case .featured:
            titleLabel.textColor = AppColor.accent
            dot.isHidden = false
        case .list:
            titleLabel.textColor = AppColor.textTertiary
            dot.isHidden = true
        }

        setupStack()
    }

    private func setupStack() {
        stack.addArrangedSubview(dot)
        stack.addArrangedSubview(titleLabel)
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),

            dot.widthAnchor.constraint(equalToConstant: AppSize.liveDot),
            dot.heightAnchor.constraint(equalToConstant: AppSize.liveDot),
        ])
    }

    func configure(source: String) {
        titleLabel.text = source.uppercased()
    }
}
