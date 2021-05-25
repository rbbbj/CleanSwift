import Alamofire

class UsersService {
    func fetchUsers(completionHandler: @escaping (_ users: [User]?, _ error: Error?) -> ()) {
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
                            completionHandler(users, nil)
                        } catch {
                            debugPrint("Decoding in getAllComments() failed with error: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    completionHandler(nil, CustomError.dataError)
                    debugPrint("getAllComments() response.result failure: ", error)
                }
        }
    }
}
