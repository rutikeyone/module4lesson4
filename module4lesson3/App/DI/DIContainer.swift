import FactoryKit
import Pulse
import Alamofire

extension Container {
    var apiSession: Factory<Session> {
        self {
            #if DEBUG
            let eventMonitors: [EventMonitor] = [NetworkLoggerEventMonitor()]
            #else
            let eventMonitors: [EventMonitor] = []
            #endif

            return Alamofire.Session(
                interceptor: APIKeyInterceptor(),
                eventMonitors: eventMonitors
            )
        }
        .singleton
    }

    var newsService: Factory<NewsServiceProtocol> {
        self { NewsService(session: self.apiSession()) }
    }
}
