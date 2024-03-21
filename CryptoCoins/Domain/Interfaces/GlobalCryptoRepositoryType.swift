import Foundation

protocol GlobalCryptoRepositoryType {
    func getGlobalCryptoList() async -> Result<[CryptoCurrency], CryptoCurrencyDomainError>
}
