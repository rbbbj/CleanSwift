import Alamofire

class UsersService {
    func fetchUsers() async throws -> [User] {
        do {
            let dataResponse = try await AF
                .request(UsersNetworkingRouter.getAllUsers)
                .validate()
                .serializingData()
                .value
            
            let usersResponse = try JSONDecoder().decode([UserResponse].self, from: dataResponse)
            return usersResponse.compactMap { try? User(from: $0) }
        } catch let afError as AFError {
            throw DataLoadingError.networkFailure(statusCode: afError.responseCode?.description ?? "Unknown")
        } catch {
            throw DataLoadingError.invalidData
        }
    }
}
