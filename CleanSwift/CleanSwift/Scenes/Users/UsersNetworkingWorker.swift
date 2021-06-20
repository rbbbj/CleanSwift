import Alamofire

class UsersNetworkingWorker {
    typealias NetworkResult = (Result<[User], DataLoadingError>) -> Void
    
    var usersService: UsersService
    
    init(useMock: Bool = false) {
        useMock ? (usersService = UsersServiceMock()) : (usersService = UsersService())
    }
    
    func fetchUsers(completionHandler: @escaping NetworkResult) {
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
