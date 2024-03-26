import Foundation

class CryptoDetailFactory: CreateCryptoDetailViewProtocol {
    func createView(cryptoCurrency: CryptoCurrencyViewItem) -> CryptoDetailView {
        return CryptoDetailView(viewModel: createViewModel(cryptoCurrency: cryptoCurrency))
    }
    
    private func createViewModel(cryptoCurrency: CryptoCurrencyViewItem) -> CryptoDetailViewModel {
        return CryptoDetailViewModel(cryptoCurrency: cryptoCurrency,
                                     getPriceHistoryUseCase: createUseCaseFactory(),
                                     errorMapper: PresentationErrorMapper())
    }
    
    private func createUseCaseFactory() -> GetPriceHistoryUseCaseProtocol {
        return GetPriceHistoryUseCase(repository: createRepository())
    }
    
    private func createRepository() -> PriceHistoryRepositoryProtocol {
        return PriceHistoryRepository(dataSource: createDataSource(),
                                      domainMapper: PriceHistoryDomainMapper(),
                                      errorMapper: DomainErrorMapper())
    }
    
    private func createDataSource() -> APIPricesDataSource {
        return APIPricesDataSource(httpClient: createHTTPClient())
    }
    
    private func createHTTPClient() -> HTTPClientProtocol {
        return HTTPClient(requestBuilder: HTTPRequestBuilder(),
                          errorsResolver: HTTPErrorsResolver())
    }
}
