import UIKit

final class FeaturedNewsCardListViewController: UIViewController {

    private struct Item {
        let source: String
        let title: String
        let meta: String
        let imageURL: URL?
    }

    private let tableView = UITableView(frame: .zero, style: .plain)

    private let items: [Item] = [
        Item(source: "PBS",
             title: "With a stalemate in Ukraine and discontent at home, Putin seems ready to escalate his war",
             meta: "29 мая 2026 · 1 ч назад",
             imageURL: URL(string: "https://d3i6fh83elv35t.cloudfront.net/static/2026/05/2026-05-29T163202Z_1749635667_RC24JLA66S0A_RTRMADP_3_KAZAKHSTAN-RUSSIA-SUMMIT-PUTIN-1024x679.jpg")),
        Item(source: "ANSA",
             title: "Un drone colpisce la Romania. Putin: 'Potrebbe essere ucraino'",
             meta: "29 мая 2026 · 2 ч назад",
             imageURL: URL(string: "https://www.ansa.it/webimages/img_1129x635/2026/5/29/7ce85d093258ac6380c9d831636fe175.jpg")),
        Item(source: "POLITICO",
             title: "Romania asks for NATO support after Russian drone crash",
             meta: "29 мая 2026 · 3 ч назад",
             imageURL: URL(string: "https://www.politico.eu/cdn-cgi/image/width=1200,height=630,fit=crop,quality=80/wp-content/uploads/2026/05/29/Oana-Toiu-scaled.jpg")),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FeaturedNewsCard"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = AppColor.backgroundPrimary

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 280
        tableView.dataSource = self
        tableView.register(FeaturedNewsCard.self, forCellReuseIdentifier: FeaturedNewsCard.reuseID)

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension FeaturedNewsCardListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FeaturedNewsCard.reuseID,
            for: indexPath
        ) as? FeaturedNewsCard else {
            return FeaturedNewsCard()
        }
        
        let item = items[indexPath.row]
        cell.configure(source: item.source, title: item.title, meta: item.meta, imageURL: item.imageURL)
        
        return cell
    }
}

#Preview {
    UINavigationController(rootViewController: FeaturedNewsCardListViewController())
}
