import Foundation

struct CryptoCurrencyGlobalInfoDTO: Codable {
    let data: CryptoCurrencyGlobalData
    
    struct CryptoCurrencyGlobalData: Codable {
        let cryptoCurrencies: [String: Double]
        
        enum CodingKeys: String, CodingKey {
            case cryptoCurrencies = "market_cap_percentage"
        }
    }
}
