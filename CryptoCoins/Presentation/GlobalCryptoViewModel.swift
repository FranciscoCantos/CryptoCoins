import Foundation

class GlobalCryptoViewModel: ObservableObject {
    
    private let getGlobalCryptoListUseCase: GetGlobalCryptoListUseCaseProtocol
    private let errorMapper: PresentationErrorMapper
    
    @Published var cryptos: [CryptoCurrencyViewItem] = []
    @Published var showLoading: Bool = false
    @Published var errorMessage: String?

    init(getGlobalCryptoListUseCase: GetGlobalCryptoListUseCaseProtocol, errorMapper: PresentationErrorMapper) {
        self.getGlobalCryptoListUseCase = getGlobalCryptoListUseCase
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        showLoading = true
        Task {
            let result = await getGlobalCryptoListUseCase.execute()
            
            guard case .success(let cryptos) = result else {
                handleError(error: result.failureValue as? DomainError)
                return
            }
            
            let cryptoCurrencies = cryptos.map({ CryptoCurrencyViewItem(model: $0) })

            Task { @MainActor in
                self.showLoading = false
                self.errorMessage = nil
                self.cryptos = cryptoCurrencies
            }
        }
    }
    
    private func handleError(error: DomainError?) {
        Task { @MainActor in
            showLoading = false
            errorMessage = errorMapper.map(error: error)
        }
    }
}
