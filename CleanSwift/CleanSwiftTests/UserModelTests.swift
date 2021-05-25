import XCTest
@testable import CleanSwift

class UserModelTests: XCTestCase {
    
    // MARK: - Properties

    var userModel: User!

    // MARK: - Set Up & Tear Down

    override func setUpWithError() throws {
        let data = loadStub(name: "users", extension: "json")
        let usersResponse = try JSONDecoder().decode([UserResponse].self, from: data)
        var users = [User]()
        usersResponse.forEach {
            if let user = try? User(from: $0) {
                users.append(user)
            }
        }
        
        userModel = users.first
    }

    override func tearDownWithError() throws {

    }

    // Tests
    
    func testSetNewUserPhone() throws {
        userModel.set(phone: "1-770-736-8031 xXXXXX")
        
        XCTAssertEqual(userModel.phone!, "1-770-736-8031 xXXXXX")
    }
    
    func testSetNewUserAddress() throws {
        let testLocation = Location(lat: "1.1111", lng: "2.2222")
        let newAddress = Address(street: "testStreet",
                                 suite: "testSuite",
                                 city: "testCity",
                                 zipcode: "testZipcode",
                                 geo: testLocation)
        userModel.set(address: newAddress)
        
        XCTAssertEqual(userModel.address!.street!, "testStreet")
        XCTAssertEqual(userModel.address!.suite!, "testSuite")
        XCTAssertEqual(userModel.address!.city!, "testCity")
        XCTAssertEqual(userModel.address!.zipcode!, "testZipcode")
        XCTAssertEqual(userModel.address!.geo!.lat, "1.1111")
        XCTAssertEqual(userModel.address!.geo!.lng, "2.2222")
    }
}
