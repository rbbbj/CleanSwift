import Foundation

class UsersServiceMock: UsersService {
    private let json = """
    [
        {
            "id": 1,
            "name": "Leanne Graham TEST",
            "username": "Bret",
            "email": "Sincere@april.biz",
            "address": {
                "street": "Kulas Light",
                "suite": "Apt. 556",
                "city": "Gwenborough",
                "zipcode": "92998-3874",
                "geo": {
                    "lat": "-37.3159",
                    "lng": "81.1496"
                }
            },
            "phone": "1-770-736-8031 x56442",
            "website": "hildegard.org",
            "company": {
                "name": "Romaguera-Crona",
                "catchPhrase": "Multi-layered client-server neural-net",
                "bs": "harness real-time e-markets"
            }
        }
    ]
    """

    override func fetchUsers() async throws -> [User] {
        guard let data = json.data(using: .utf8) else {
            throw DataLoadingError.invalidData
        }

        do {
            let usersResponse = try JSONDecoder().decode([UserResponse].self, from: data)
            return usersResponse.compactMap { try? User(from: $0) }
        } catch {
            throw DataLoadingError.invalidData
        }
    }
}
