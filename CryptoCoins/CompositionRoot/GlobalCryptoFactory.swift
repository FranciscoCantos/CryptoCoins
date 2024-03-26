import Foundation

class GlobalCryptoFactory {
    func createView() -> GlobalCryptoView {
        return GlobalCryptoView(viewModel: createViewModel(), 
                                createCryptoDetailView: CryptoDetailFactory())
    }
    
    private func createViewModel() -> GlobalCryptoViewModel {
        return GlobalCryptoViewModel(getGlobalCryptoListUseCase: createUseCaseFactory(), 
                                     errorMapper: PresentationErrorMapper())
    }
    
    private func createUseCaseFactory() -> GetGlobalCryptoListUseCaseProtocol {
        return GetGlobalCryptoListUseCase(repository: createRepository())
    }
    
    private func createRepository() -> GlobalCryptoRepositoryProtocol {
        return GlobalCryptoRepository(apiDataSource: createDataSource(),
                                      errorMapper: DomainErrorMapper(),
                                      domainMapper: CryptoCurrencyDomainMapper())
    }
    
    private func createDataSource() -> APICurrenciesDataSourceProtocol {
        return APICurrenciesDataSource(httpClient: createHTTPClient())
    }
    
    private func createHTTPClient() -> HTTPClientProtocol {
        return HTTPClient(requestBuilder: HTTPRequestBuilder(),
                          errorsResolver: HTTPErrorsResolver())
    }
}
