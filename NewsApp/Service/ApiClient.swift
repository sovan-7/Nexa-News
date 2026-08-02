import Foundation


protocol ApiClientProtocol {
    func request<T: Decodable>(urlString: String) async throws -> T
}
class APIClient :ApiClientProtocol{
    
    static let shared = APIClient()
    
    func request<T: Decodable>(urlString: String) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            print("❌ INVALID URL: \(urlString)")
            throw APIError.invalidURL
        }
        
        print("🌐 REQUESTING: \(urlString)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("❌ NOT A HTTP RESPONSE")
            throw APIError.invalidResponse
        }
        
        print("📡 STATUS CODE: \(httpResponse.statusCode)")
        
        guard httpResponse.statusCode == 200 else {
            let rawResponse = String(data: data, encoding: .utf8) ?? "No body"
            print("❌ BAD STATUS CODE: \(httpResponse.statusCode)")
            print("❌ RESPONSE BODY: \(rawResponse)")
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601  // ← fixes date parsing
            let decoded = try decoder.decode(T.self, from: data)
            print("✅ DECODED SUCCESSFULLY")
            return decoded
        } catch {
            let rawResponse = String(data: data, encoding: .utf8) ?? "No body"
            print("❌ DECODING ERROR: \(error)")
            print("❌ RAW JSON: \(rawResponse)")
            throw APIError.decodingError
        }
    }
}
