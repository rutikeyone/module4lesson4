import UIKit

final class TypographyViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    private let samples: [(String, UIFont)] = [
        ("largeTitle — 34 / Bold", AppFont.largeTitle),
        ("sectionTitle — 22 / Bold", AppFont.sectionTitle),
        ("featuredTitle — 20 / Bold", AppFont.featuredTitle),
        ("body — 17 / Regular", AppFont.body),
        ("button — 17 / Semibold", AppFont.button),
        ("callout — 16 / Regular", AppFont.callout),
        ("newsTitle — 16 / Semibold", AppFont.newsTitle),
        ("count — 15 / Regular", AppFont.count),
        ("body2 — 14 / Regular", AppFont.body2),
        ("footnote — 13 / Regular", AppFont.footnote),
        ("caption — 12 / Semibold", AppFont.caption),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Typography"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = AppColor.backgroundPrimary

        setupLayout()
        samples.forEach { addSample(text: $0.0, font: $0.1) }
    }

    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = AppSpacing.l
        contentStack.isLayoutMarginsRelativeArrangement = true
        contentStack.layoutMargins = UIEdgeInsets(
            top: AppSpacing.l, left: AppSpacing.xl,
            bottom: AppSpacing.xl, right: AppSpacing.xl
        )

        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }

    private func addSample(text: String, font: UIFont) {
        let label = UILabel()
        
        label.text = text
        label.font = font
        label.textColor = AppColor.textPrimary
        label.numberOfLines = 0
        
        contentStack.addArrangedSubview(label)
    }
}

#Preview {
    UINavigationController(rootViewController: TypographyViewController())
}
