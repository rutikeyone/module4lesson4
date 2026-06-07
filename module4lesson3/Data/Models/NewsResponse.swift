nonisolated struct NewsResponse: Decodable, Sendable {
    let status: String
    let totalResults: Int
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles = "results"
    }
}
