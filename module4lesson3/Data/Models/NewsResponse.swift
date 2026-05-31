nonisolated struct NewsResponse: Decodable, Sendable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
