import FactoryKit

extension Container {
    var newsService: Factory<NewsServiceProtocol> {
        self { NewsService() }
    }
}
