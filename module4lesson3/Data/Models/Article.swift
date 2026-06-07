nonisolated struct Article: Decodable, Sendable {
    let articleId: String
    let title: String
    let description: String?
    let imageUrl: String?
    let pubDate: String
    let sourceName: String?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case articleId = "article_id"
        case title
        case description
        case imageUrl = "image_url"
        case pubDate
        case sourceName = "source_name"
        case link
    }
}
