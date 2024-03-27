import Foundation

class CryptoCurrencyBasicInfoCacheStrategy: CacheCurrenciesBasicDataSourceProtocol {
    private let temporalCache: CacheCurrenciesBasicDataSourceProtocol
    private let persistanceCache: CacheCurrenciesBasicDataSourceProtocol
    
    init(temporalCache: any CacheCurrenciesBasicDataSourceProtocol, persitanceCache: any CacheCurrenciesBasicDataSourceProtocol) {
        self.temporalCache = temporalCache
        self.persistanceCache = persitanceCache
    }
    
    func getBasicCryptoCurrencies() async -> [CryptoCurrencyBasicInfo] {
        let temporalCryptoList = await temporalCache.getBasicCryptoCurrencies()
        if !temporalCryptoList.isEmpty {
            return temporalCryptoList
        }
        
        let persistanceCryptoList = await persistanceCache.getBasicCryptoCurrencies()
        await temporalCache.saveBasicCryptoList(persistanceCryptoList)
        
        return persistanceCryptoList
    }
    
    func saveBasicCryptoList(_ cryptoList: [CryptoCurrencyBasicInfo]) async {
        await temporalCache.saveBasicCryptoList(cryptoList)
        await persistanceCache.saveBasicCryptoList(cryptoList)
    }
}
