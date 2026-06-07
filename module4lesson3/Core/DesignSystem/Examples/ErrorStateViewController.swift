import UIKit

final class ErrorStateViewController: UIViewController {

    private let errorView = ErrorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.Examples.errorStateTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = AppColor.backgroundPrimary

        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.onRetry = { print("tapped") }
        view.addSubview(errorView)

        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

#Preview {
    UINavigationController(rootViewController: ErrorStateViewController())
}
