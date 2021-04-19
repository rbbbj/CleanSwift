import Alamofire

enum UsersNetworkingRouter: URLRequestConvertible {
    case getAllUsers
    
    // MARK: - HTTPMethod
    
    var method: HTTPMethod {
        switch self {
        case .getAllUsers:
            return .get
        }
    }
    
    // MARK: - path
    
    var path: String {
        switch self {
        case .getAllUsers:
            return Jsonplaceholder.Path.users
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Jsonplaceholder.baseUrl.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        // Method
        request.httpMethod = method.rawValue
        
        // Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Parameters
        switch self {
        case .getAllUsers:
            break
        }
        
        // Body
        switch self {
        case .getAllUsers:
            break
        }

        return request
    }
}
