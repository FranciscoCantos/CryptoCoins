import Foundation

protocol GetPriceHistoryUseCaseProtocol {
    func execute(id: String, days: Int) async -> Result<PriceHistory, DomainError>
}

class GetPriceHistoryUseCase: GetPriceHistoryUseCaseProtocol {
    private let repository: PriceHistoryRepositoryProtocol
    
    internal init(repository: PriceHistoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: String, days: Int) async -> Result<PriceHistory, DomainError> {
        return await repository.getPriceHistory(id: id, days: days)
    }
}
