import Foundation

enum Strings {

    enum News {
        static let title = "news.title".localized
        static let searchPlaceholder = "news.search.placeholder".localized
        static let defaultQuery = "news.search.default_query".localized
        static let sectionAll = "news.section.all".localized
    }

    enum NewsDetails {
        static let read = "news.details.read".localized
        static let noticeTitle = "news.details.notice.title".localized
        static let noticeSubtitle = "news.details.notice.subtitle".localized
        static let sourceButton = "news.details.source_button".localized
    }

    enum SearchEmpty {
        static let title = "search.empty.title".localized
        static let description = "search.empty.description".localized
    }

    enum Error {
        static let title = "error.title".localized
        static let retry = "error.retry".localized
    }

    enum Examples {
        static let errorStateTitle = "example.error_state.title".localized
    }
}
