import Foundation

protocol PriceHistoryRepositoryProtocol {
    func getPriceHistory(id: String, days: Int) async -> Result<PriceHistory, DomainError>
}
