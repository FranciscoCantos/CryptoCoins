import Foundation

class GlobalCryptoRepository: GlobalCryptoRepositoryProtocol {
    private let apiDataSource: APICurrenciesDataSourceProtocol
    private let errorMapper: DomainErrorMapper
    private let domainMapper: CryptoCurrencyDomainMapper
    
    init(apiDataSource: APICurrenciesDataSourceProtocol, errorMapper: DomainErrorMapper, domainMapper: CryptoCurrencyDomainMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.domainMapper = domainMapper
    }
    
     func getGlobalCryptoList() async -> Result<[CryptoCurrency], DomainError> {
        let symbolsResult = await apiDataSource.getGlobalCryptoSimbols()
        let cryptosResult = await apiDataSource.getCryptoCurrencies()
        
        guard case .success(let symbolsResult) = symbolsResult else {
            return .failure(errorMapper.map(error: symbolsResult.failureValue as? HTTPClientError))
        }
        
        guard case .success(let cryptosList) = cryptosResult else {
            return .failure(errorMapper.map(error: cryptosResult.failureValue as? HTTPClientError))
        }
        
        let builders = domainMapper.getCryptoCurrencyBuilders(symbols: symbolsResult, cryptos: cryptosList)
        let ids = builders.map { $0.id }
        
        let priceInfoResult = await apiDataSource.getPriceInfoForCryptos(id: ids)
        
        guard case .success(let priceInfoResult) = priceInfoResult else {
            return .failure(errorMapper.map(error: priceInfoResult.failureValue as? HTTPClientError))
        }
        
        let cryptoCurrency = domainMapper.map(cryptoCurrencyBuilders: builders, priceInfo: priceInfoResult)
        return .success(cryptoCurrency)
    }
}
