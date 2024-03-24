import Foundation
 
class APICurrenciesDataSource: APICurrenciesDataSourceProtocol {
    private let httpClient: HTTPClientProtocol
    private let baseURL = "https://api.coingecko.com/api/v3/"
    
    private enum Paths: String {
        case global = "global"
        case coinsList = "coins/list"
        case simplePrice = "simple/price"
    }
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }

    func getGlobalCryptoSimbols() async -> Result<[String], HTTPClientError> {
        let request = HTTPRequest(baseURL: baseURL,
                                  path: Paths.global.rawValue,
                                  method: .get)
        let result = await httpClient.makeRequest(request)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        guard let symbols = try? JSONDecoder().decode(CryptoCurrencyGlobalInfoDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        
        let cryptoCurrenciesSymbols = symbols.data.cryptoCurrencies.map { $0.key }
        return .success(cryptoCurrenciesSymbols)

    }
    
    func getCryptoCurrencies() async -> Result<[CryptoCurrencyBasicDTO], HTTPClientError> {
        let request = HTTPRequest(baseURL: baseURL,
                                  path: Paths.coinsList.rawValue,
                                  method: .get)
        let result = await httpClient.makeRequest(request)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        guard let cryptos = try? JSONDecoder().decode([CryptoCurrencyBasicDTO].self, from: data) else {
            return .failure(.parsingError)
        }
        
        return .success(cryptos)
    }
    
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptoCurrencyPriceInfoDTO], HTTPClientError> {
        let params: [String: Any] = [
            "ids": id.joined(separator: ","),
            "vs_currencies": "usd", // Kurro TODO
            "include_market_cap": "true",
            "include_24hr_vol": "true",
            "include_24hr_change": "true"
        ]
        let request = HTTPRequest(baseURL: baseURL,
                                  path: Paths.simplePrice.rawValue,
                                  method: .get,
                                  queryParams: params)
        let result = await httpClient.makeRequest(request)
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        guard let cryptoPrices = try? JSONDecoder().decode([String: CryptoCurrencyPriceInfoDTO].self, from: data) else {
            return .failure(.parsingError)
        }
        
        return .success(cryptoPrices)
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else { return .generic }
        
        return error
    }
}
