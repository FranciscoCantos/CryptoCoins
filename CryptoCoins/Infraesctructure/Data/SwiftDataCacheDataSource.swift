import Foundation

class SwiftDataCacheDataSource: CacheCurrenciesBasicDataSourceProtocol {
    private let container: SwiftDataContainerProtocol
    
    init(container: any SwiftDataContainerProtocol) {
        self.container = container
    }
    
    func getBasicCryptoCurrencies() async -> [CryptoCurrencyBasicInfo] {
        let result = container.fetchCryptos()
        let cryptos = result.map { CryptoCurrencyBasicInfo(id: $0.id, name: $0.name, symbol: $0.symbol) }
        return cryptos
    }
    
    func saveBasicCryptoList(_ cryptoList: [CryptoCurrencyBasicInfo]) async {
        let cryptos = cryptoList.map { CryptoCurrencyInfoBasicData(id: $0.id, name: $0.name, symbol: $0.symbol) }
        await container.insertCryptos(cryptos)
    }
}
