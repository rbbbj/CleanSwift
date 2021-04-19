import Alamofire

class UsersNetworkingWorker {
    let useMock = true
    var usersService: UsersService
    
    init() {
        useMock ? (usersService = UsersServiceMock()) : (usersService = UsersService())
    }
    
    func fetchUsers(completionHandler: @escaping (_ users: [User]?, _ error: Error?) -> Void) {
        usersService.fetchUsers { users, error in
            if let error = error {
                completionHandler(nil, error)
            } else {
                completionHandler(users, nil)
            }
        }
    }
}
