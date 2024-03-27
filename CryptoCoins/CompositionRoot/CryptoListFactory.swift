import Foundation

class CryptoListFactory {
    func createView() -> CryptoListView {
        return CryptoListView(viewModel: createViewModel())
    }
    
    private func createViewModel() -> CryptoListViewModel {
        return CryptoListViewModel(getCryptoListUseCase: createGetCryptoListUseCase(),
                                   searchCryptoListUseCase: createSearchCryptoListUseCase(),
                                     errorMapper: PresentationErrorMapper())
    }
    
    private func createGetCryptoListUseCase() -> GetCryptoListUseCaseProtocol {
        return GetCryptoListUseCase(repository: createRepository())
    }
    
    private func createSearchCryptoListUseCase() -> SearchCryptoListUseCase {
        return SearchCryptoListUseCase(repository: createRepository())
    }
    
    private func createRepository() -> CryptoCurrencyRepositoryProtocol {
        return CryptoCurrencyRepository(apiDataSource: createDataSource(),
                                        cacheDataSource: createCacheDataSource(),
                                      errorMapper: DomainErrorMapper())
    }
    
    private func createCacheDataSource() -> CacheCurrenciesBasicDataSourceProtocol {
        return CacheCurrenciesBasicDataSource.shared()
    }
    
    private func createDataSource() -> APICurrenciesBasicDataSourceProtocol {
        return APICurrenciesDataSource(httpClient: createHTTPClient())
    }
    
    private func createHTTPClient() -> HTTPClientProtocol {
        return HTTPClient(requestBuilder: HTTPRequestBuilder(),
                          errorsResolver: HTTPErrorsResolver())
    }
}
