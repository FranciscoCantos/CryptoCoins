import Foundation

class DomainErrorMapper {
    func map(error: HTTPClientError?) -> DomainError {
        guard error == .tooManyRequest else {
            return .generic
        }
        return .tooManyRequest
    }
}
