import Foundation
 
protocol GlobalCryptoRepositoryProtocol {
    func getGlobalCryptoList() async -> Result<[CryptoCurrency], DomainError>
}
