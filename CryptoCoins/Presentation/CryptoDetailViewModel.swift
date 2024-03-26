import Foundation

class CryptoDetailViewModel: ObservableObject {
    
    private let getPriceHistoryUseCase: GetPriceHistoryUseCaseProtocol
    private let errorMapper: PresentationErrorMapper
    let cryptoCurrency: CryptoCurrencyViewItem
    
    @Published var dataPoints: [ChartDataPoint] = []
    @Published var showLoading: Bool = false
    @Published var errorMessage: String?
    
    init(cryptoCurrency: CryptoCurrencyViewItem, getPriceHistoryUseCase: GetPriceHistoryUseCaseProtocol, errorMapper: PresentationErrorMapper) {
        self.cryptoCurrency = cryptoCurrency
        self.getPriceHistoryUseCase = getPriceHistoryUseCase
        self.errorMapper = errorMapper
    }
        
    func onAppear() {
        getPriceHistory(option: .month)
    }
    
    func getPriceHistory(option: DaysSelection) {
        showLoading = true
        errorMessage = nil
        Task {
            let result = await getPriceHistoryUseCase.execute(id: cryptoCurrency.id, days: option.intValue)
            
            guard case .success(let priceHistory) = result else {
                handleError(error: result.failureValue as? DomainError)
                return
            }
            let dataPoints = priceHistory.prices.map { ChartDataPoint(date: $0.date, price: $0.price) }
            
            Task { @MainActor in
                showLoading = false
                self.dataPoints = dataPoints
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
