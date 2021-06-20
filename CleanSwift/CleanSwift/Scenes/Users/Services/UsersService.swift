import Alamofire

class UsersService {
    typealias NetworkResult = (Result<[User], DataLoadingError>) -> Void
    
    func fetchUsers(completionHandler: @escaping NetworkResult) {
        AF
            .request(UsersNetworkingRouter.getAllUsers)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    if let jsonData = response.data {
                        do {
                            let usersResponse = try JSONDecoder().decode([UserResponse].self, from: jsonData)
                            var users = [User]()
                            usersResponse.forEach {
                                if let user = try? User(from: $0) {
                                    users.append(user)
                                }
                            }
                            completionHandler(.success(users))
                        } catch {
                            completionHandler(.failure(.invalidData))
                        }
                    }
                case .failure:
                    var statusCode: String
                    if let responseStatusCode = response.response?.statusCode {
                        statusCode = String(responseStatusCode)
                    } else {
                        statusCode = "Unknown"
                    }
                    completionHandler(.failure(.networkFailure(statusCode: statusCode)))
                }
        }
    }
}
