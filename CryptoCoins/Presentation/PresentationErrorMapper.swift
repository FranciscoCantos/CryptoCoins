import Foundation

class PresentationErrorMapper {
    func map(error: DomainError?) -> String {
        guard error == .tooManyRequest else {
            return "Something went wrong"
        }
        
        return "Request limit reached. Try again later"
    }
}
