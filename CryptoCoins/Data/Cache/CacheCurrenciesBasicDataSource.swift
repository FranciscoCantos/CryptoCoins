import Foundation

protocol CacheCurrenciesBasicDataSourceProtocol {
    func getBasicCryptoCurrencies() async -> [CryptoCurrencyBasicInfo]
    func saveBasicCryptoList(_ cryptoList: [CryptoCurrencyBasicInfo]) async
}

actor CacheCurrenciesBasicDataSource: CacheCurrenciesBasicDataSourceProtocol {
    private static let sharedInstance = CacheCurrenciesBasicDataSource()
    private var cacheCryptoList: [CryptoCurrencyBasicInfo] = []
    
    private init() {}
    
    static func shared() -> CacheCurrenciesBasicDataSource {
        return sharedInstance
    }
    
    func getBasicCryptoCurrencies() async -> [CryptoCurrencyBasicInfo] {
        return cacheCryptoList
    }
    
    func saveBasicCryptoList(_ cryptoList: [CryptoCurrencyBasicInfo]) async {
        self.cacheCryptoList = cryptoList
    }
}
