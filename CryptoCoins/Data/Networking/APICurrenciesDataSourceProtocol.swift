import Foundation

protocol APICurrenciesDataSourceProtocol {
    func getGlobalCryptoSimbols() async -> Result<[String], HTTPClientError>
    func getCryptoCurrencies() async -> Result<[CryptoCurrencyBasicDTO], HTTPClientError>
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptoCurrencyPriceInfoDTO], HTTPClientError>
}
