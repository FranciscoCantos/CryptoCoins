import Foundation

class CryptoCurrencyDomainMapper {
    func getCryptoCurrencyBuilders(symbols: [String], cryptos: [CryptoCurrencyBasicDTO]) -> [CryptoCurrencyBuilder] {
        var symbolsDict: [String: Bool] = [:]
        
        symbols.forEach {
            symbolsDict[$0] = true
        }
        
        let filteredCryptos = cryptos.filter { symbolsDict[$0.symbol] ?? false }
        let cryptoBuilders = filteredCryptos.map { CryptoCurrencyBuilder(id: $0.id, name: $0.name, symbol: $0.symbol)}
        return cryptoBuilders
    }
    
    func map(cryptoCurrencyBuilders: [CryptoCurrencyBuilder], priceInfo: [String: CryptoCurrencyPriceInfoDTO]) -> [CryptoCurrency] {
        cryptoCurrencyBuilders.forEach {
            if let priceInfo = priceInfo[$0.id] {
                $0.price = priceInfo.price
                $0.volume24h = priceInfo.volume24h
                $0.marketCap = priceInfo.marketCap
                $0.price24h = priceInfo.price24h
            }
        }
        return cryptoCurrencyBuilders.compactMap { $0.build() }
    }
}
