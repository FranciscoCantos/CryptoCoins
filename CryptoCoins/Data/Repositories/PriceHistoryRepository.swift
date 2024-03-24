import Foundation

class PriceHistoryRepository: PriceHistoryRepositoryProtocol {
    private let dataSource: APIPricesDataSource
    private let domainMapper: PriceHistoryDomainMapper
    private let errorMapper: DomainErrorMapper
    
    init(dataSource: APIPricesDataSource, domainMapper: PriceHistoryDomainMapper, errorMapper: DomainErrorMapper) {
        self.dataSource = dataSource
        self.domainMapper = domainMapper
        self.errorMapper = errorMapper
    }
    
    func getPriceHistory(id: String, days: Int) async -> Result<PriceHistory, DomainError> {
        let result = await dataSource.getPriceHistory(id: id, days: days)
        
        guard case .success(let priceHistory) = result else {
            return .failure(errorMapper.map(error: result.failureValue as? HTTPClientError))
        }
        
        return .success(domainMapper.map(model: priceHistory))
    }
}
