import Foundation

class APIPricesDataSource: APIPricesDataSourceProtocol {
    private let httpClient: HTTPClientProtocol
    private let baseURL = "https://api.coingecko.com/api/v3/"
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getPriceHistory(id: String, days: Int) async -> Result<PriceHistoryDTO, HTTPClientError> {
        let params: [String: Any] = [
            "vs_currencies": "usd", // Kurro TODO
            "days": days,
            "interval": "daily",
        ]
        let request = HTTPRequest(baseURL: baseURL,
                                  path: "coins/\(id)/market_chart",
                                  method: .get,
                                  queryParams: params)
        let result = await httpClient.makeRequest(request)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        guard let priceHistory = try? JSONDecoder().decode(PriceHistoryDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        
        return .success(priceHistory)
    }
    
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else { return .generic }
        
        return error
    }
}
