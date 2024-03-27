import Foundation

import Foundation

class CryptoListViewModel: ObservableObject {
    private let getCryptoListUseCase: GetCryptoListUseCaseProtocol
    private let searchCryptoListUseCase: SearchCryptoListUseCaseProtocol
    private let errorMapper: PresentationErrorMapper
    
    @Published var cryptos: [CryptoCurrencyBasicViewItem] = []
    @Published var showLoading: Bool = false
    @Published var errorMessage: String?

    init(getCryptoListUseCase: GetCryptoListUseCaseProtocol, searchCryptoListUseCase: SearchCryptoListUseCase, errorMapper: PresentationErrorMapper) {
        self.getCryptoListUseCase = getCryptoListUseCase
        self.searchCryptoListUseCase = searchCryptoListUseCase
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        showLoading = true
        Task {
            let result = await getCryptoListUseCase.execute()
            handleResult(result)
        }
    }
    
    func search(cryptoName: String) {
        Task {
            let result = await searchCryptoListUseCase.execute(cryptoName: cryptoName)
            handleResult(result)
        }
    }
    
    private func handleResult(_ result: Result<[CryptoCurrencyBasicInfo], DomainError>) {
        guard case .success(let cryptos) = result else {
            handleError(error: result.failureValue as? DomainError)
            return
        }
        
        let cryptoCurrencies = cryptos.map({ CryptoCurrencyBasicViewItem(id: $0.id, name: $0.name, symbol: $0.symbol) })

        Task { @MainActor in
            self.showLoading = false
            self.errorMessage = nil
            self.cryptos = cryptoCurrencies
        }
    }
    
    private func handleError(error: DomainError?) {
        Task { @MainActor in
            showLoading = false
            errorMessage = errorMapper.map(error: error)
        }
    }
}
