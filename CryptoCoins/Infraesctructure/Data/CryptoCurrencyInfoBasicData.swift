import Foundation
import SwiftData

@Model
class CryptoCurrencyInfoBasicData {
    let id: String
    let name: String
    let symbol: String
    
    init(id: String, name: String, symbol: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
    }
}

