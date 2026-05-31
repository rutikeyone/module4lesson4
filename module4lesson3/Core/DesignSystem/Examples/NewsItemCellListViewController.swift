import UIKit

final class NewsItemCellListViewController: UIViewController {

    private struct Item {
        let source: String
        let title: String
        let description: String?
        let time: String
        let imageURL: URL?
    }

    private let tableView = UITableView(frame: .zero, style: .plain)

    private let items: [Item] = [
        Item(source: "CNBC",
             title: "Mercedes-Benz may be shut out of U.S. market under bill aimed at Chinese ownership",
             description: "Mercedes-Benz's largest individual shareholder is BAIC, a Chinese state-owned automaker.",
             time: "1 ч назад",
             imageURL: URL(string: "https://image.cnbcfm.com/api/v1/image/108125235-17436227212025-04-02t193536z_1877750598_rc2spday6c4t_rtrmadp_0_usa-trump-tariffs.jpeg?v=1743622786&w=1920&h=1080")),
        Item(source: "ANSA",
             title: "Un drone colpisce la Romania. Putin: 'Potrebbe essere ucraino'",
             description: "Medvedev ai cittadini UE: siate vigili. Bucarest dichiara il console russo persona non grata.",
             time: "2 ч назад",
             imageURL: URL(string: "https://www.ansa.it/webimages/img_1129x635/2026/5/29/7ce85d093258ac6380c9d831636fe175.jpg")),
        Item(source: "RT",
             title: "Ukraine killed 21 Russian students and lied about it: What really happened in Starobelsk",
             description: nil,
             time: "1 ч назад",
             imageURL: nil),
        Item(source: "New York Post",
             title: "Putin's $26B mission to live forever includes 3D printed flesh and organ transplants",
             description: "Putin has sunk billions into outlandish human longevity experiments.",
             time: "2 ч назад",
             imageURL: URL(string: "https://nypost.com/wp-content/uploads/sites/2/2026/05/129084579.jpg?quality=75&strip=all&w=1200")),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NewsItemCell"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = AppColor.backgroundPrimary

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorColor = AppColor.separatorOpaque
        tableView.separatorInset = UIEdgeInsets(top: 0, left: AppSpacing.l, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.register(NewsItemCell.self, forCellReuseIdentifier: NewsItemCell.reuseID)

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension NewsItemCellListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsItemCell.reuseID,
            for: indexPath
        ) as? NewsItemCell else {
            return NewsItemCell()
        }
        
        let item = items[indexPath.row]
        cell.configure(
            source: item.source,
            title: item.title,
            description: item.description,
            time: item.time,
            imageURL: item.imageURL
        )
        
        return cell
    }
}

#Preview {
    UINavigationController(rootViewController: NewsItemCellListViewController())
}
