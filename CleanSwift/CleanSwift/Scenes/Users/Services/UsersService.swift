import Alamofire

class UsersService {
    typealias Handler = (Result<[User], DataLoadingError>) -> Void
    
    func fetchUsers(completionHandler: @escaping Handler) {
        AF
            .request(UsersNetworkingRouter.getAllUsers)
            .validate()
            .responseJSON { response in
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
