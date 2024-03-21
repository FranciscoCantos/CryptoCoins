import Foundation

class CryptoCurrencyDomainErrorMapper {
    func map(error: HTTPClientError?) -> CryptoCurrencyDomainError {
        return .generic
    }
}
