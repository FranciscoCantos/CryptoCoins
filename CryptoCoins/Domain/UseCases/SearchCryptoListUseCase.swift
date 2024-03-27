
import Foundation

protocol SearchCryptoListUseCaseProtocol {
    func execute(cryptoName: String) async -> Result<[CryptoCurrencyBasicInfo], DomainError>
}

class SearchCryptoListUseCase: SearchCryptoListUseCaseProtocol {
    private let repository: CryptoCurrencyRepositoryProtocol
    
    init(repository: CryptoCurrencyRepositoryProtocol) {
       self.repository = repository
   }
    
    func execute(cryptoName: String) async -> Result<[CryptoCurrencyBasicInfo], DomainError> {
        let result = await repository.search(cryptoName: cryptoName)
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        let sortedCryptoList = cryptoList.sorted { $0.name < $1.name }
        return .success(sortedCryptoList)
    }
}
