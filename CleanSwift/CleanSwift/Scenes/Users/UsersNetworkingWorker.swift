import Alamofire

class UsersNetworkingWorker {
    var usersService: UsersService

    init(useMock: Bool = false) {
        useMock ? (usersService = UsersServiceMock()) : (usersService = UsersService())
    }

    func fetchUsers() async throws -> [User] {
        do {
            return try await usersService.fetchUsers()
        } catch DataLoadingError.networkFailure(let statusCode) {
            throw DataLoadingError.networkFailure(statusCode: statusCode)
        } catch DataLoadingError.invalidData {
            throw DataLoadingError.invalidData
        } catch {
            throw DataLoadingError.invalidData
        }
    }
}
