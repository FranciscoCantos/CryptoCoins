import Foundation

protocol APIPricesDataSourceProtocol {
    func getPriceHistory(id: String, days: Int) async -> Result<PriceHistoryDTO, HTTPClientError>
}
