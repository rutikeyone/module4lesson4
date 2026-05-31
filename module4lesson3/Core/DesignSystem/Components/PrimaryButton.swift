import UIKit

final class PrimaryButton: UIButton {

    init(title: String, image: UIImage? = nil) {
        super.init(frame: .zero)
        
        setup(title: title, image: image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(title: String, image: UIImage?) {
        var config = UIButton.Configuration.filled()
        
        config.title = title
        config.image = image
        config.imagePadding = AppSpacing.s
        config.baseBackgroundColor = AppColor.accent
        config.baseForegroundColor = AppColor.textOnAccent
        config.cornerStyle = .fixed
        config.background.cornerRadius = AppRadius.large
        config.contentInsets = NSDirectionalEdgeInsets(
            top: AppSpacing.l - 2, leading: AppSpacing.l,
            bottom: AppSpacing.l - 2, trailing: AppSpacing.l
        )
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var updated = attributes
            updated.font = AppFont.button
        
            return updated
        }
        
        self.configuration = config
    }
}
