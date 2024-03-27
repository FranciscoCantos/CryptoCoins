import Foundation

protocol CryptoCurrencyRepositoryProtocol {
    func getCryptoList() async -> Result<[CryptoCurrencyBasicInfo], DomainError>
    func search(cryptoName: String) async -> Result<[CryptoCurrencyBasicInfo], DomainError>
}

class CryptoCurrencyRepository: CryptoCurrencyRepositoryProtocol {
    private let apiDataSource: APICurrenciesBasicDataSourceProtocol
    private let cacheDataSource: CacheCurrenciesBasicDataSourceProtocol

    private let errorMapper: DomainErrorMapper
    
    init(apiDataSource: APICurrenciesBasicDataSourceProtocol, cacheDataSource: CacheCurrenciesBasicDataSourceProtocol, errorMapper: DomainErrorMapper) {
        self.apiDataSource = apiDataSource
        self.cacheDataSource = cacheDataSource
        self.errorMapper = errorMapper
    }
    
    func getCryptoList() async -> Result<[CryptoCurrencyBasicInfo], DomainError> {
        let cryptoCurrencyCache = await cacheDataSource.getBasicCryptoCurrencies()
        if !cryptoCurrencyCache.isEmpty {
            return .success(cryptoCurrencyCache)
        }

        let cryptosResult = await apiDataSource.getBasicCryptoCurrencies()
        
        guard case .success(let cryptosList) = cryptosResult else {
            return .failure(errorMapper.map(error: cryptosResult.failureValue as? HTTPClientError))
        }
        
        let cryptoListDomain = cryptosList.map { CryptoCurrencyBasicInfo(id: $0.id, name: $0.name, symbol: $0.symbol) }
        
        await cacheDataSource.saveBasicCryptoList(cryptoListDomain)
        
        return .success(cryptoListDomain)
    }
    
    func search(cryptoName: String) async -> Result<[CryptoCurrencyBasicInfo], DomainError> {
        let result = await getCryptoList()
        
        guard case .success(let cryptosList) = result else {
            return result
        }
        
        guard cryptoName != "" else {
            return result
        }
        
        let filteredCryptoList = cryptosList.filter {
            $0.name.lowercased().contains(cryptoName.lowercased()) || $0.symbol.lowercased().contains(cryptoName.lowercased())
        }
        return .success(filteredCryptoList)
    }
}
 
