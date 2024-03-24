import Foundation

struct PriceHistoryDTO: Codable {
    let prices: [[Double]]
    
    enum CodingKeys: String, CodingKey {
        case prices
    }
}
