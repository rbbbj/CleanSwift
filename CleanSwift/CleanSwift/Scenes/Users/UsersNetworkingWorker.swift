import Alamofire

class UsersNetworkingWorker {
    typealias Handler = (Result<[User], DataLoadingError>) -> Void
    
    var usersService: UsersService
    
    init(useMock: Bool = false) {
        useMock ? (usersService = UsersServiceMock()) : (usersService = UsersService())
    }
    
    func fetchUsers(completionHandler: @escaping (Result<[User], DataLoadingError>) -> Void) {
        usersService.fetchUsers { result in
            switch result {
            case .success(let users):
                completionHandler(.success(users))
            case.failure(.networkFailure(let statusCode)):
                completionHandler(.failure(DataLoadingError.networkFailure(statusCode: statusCode)))
            case.failure(.invalidData):
                completionHandler(.failure(DataLoadingError.invalidData))
            }
        }
    }
}
