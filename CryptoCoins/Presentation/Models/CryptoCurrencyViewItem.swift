import Foundation

struct CryptoCurrencyViewItem {
    let id: String
    let name: String
    let symbol: String
    let price: String
    let price24h: String
    let volume24h: String
    let marketCap: String
    let isPositive: Bool
    
    init(model: CryptoCurrency) {
        self.id = model.id
        self.name = model.name
        self.symbol = model.symbol
        self.price = "\(model.price) $"
        self.isPositive = model.price24h ?? 0 >= 0
        self.price24h = model.price24h != nil ? "\(isPositive ? "+" : "")\(model.price24h!) %" : "-"
        self.volume24h = model.volume24h != nil ? "\(model.volume24h!) $" : "-"
        self.marketCap = "\(model.marketCap) $"
    }
}
