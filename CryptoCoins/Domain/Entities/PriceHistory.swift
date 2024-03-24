import Foundation

struct PriceHistory {
    let prices: [DataPoint]
    
    struct DataPoint {
        let price: Double
        let date: Date
    }
}
