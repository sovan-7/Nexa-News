import Foundation

protocol NewsServiceProtocol {
    func fetchTopHeadlines(category: String) async throws -> [Article]
}

class NewsService:NewsServiceProtocol {
    
    static let shared = NewsService(apiClient: APIClient.shared)
    private let apiClient: ApiClientProtocol
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    func fetchTopHeadlines(category: String) async throws -> [Article] {
        
        struct Response: Codable {
            let articles: [Article]
        }
        
        let response: Response = try await apiClient.request(
            urlString: APIEndpoints.topHeadlines(category: category)
        )
        
        return response.articles
    }
}
