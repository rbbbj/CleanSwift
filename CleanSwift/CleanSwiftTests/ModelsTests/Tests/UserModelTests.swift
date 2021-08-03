import XCTest
@testable import CleanSwift

class UserModelTests: XCTestCase {
    
    // MARK: - Properties

    var sut: User!

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
        
        sut = users.first
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // Tests
    
    func testSetNewUserPhone() throws {
        sut.set(phone: "1-770-736-8031 xXXXXX")
        
        XCTAssertEqual(sut.phone, "1-770-736-8031 xXXXXX")
    }
    
    func testSetNewUserAddress() throws {
        let testLocation = Location(lat: "1.1111", lng: "2.2222")
        let newAddress = Address(street: "testStreet",
                                 suite: "testSuite",
                                 city: "testCity",
                                 zipcode: "testZipcode",
                                 geo: testLocation)
        sut.set(address: newAddress)
        
        XCTAssertEqual(sut.address.street, "testStreet")
        XCTAssertEqual(sut.address.suite, "testSuite")
        XCTAssertEqual(sut.address.city, "testCity")
        XCTAssertEqual(sut.address.zipcode, "testZipcode")
        XCTAssertEqual(sut.address.geo.lat, "1.1111")
        XCTAssertEqual(sut.address.geo.lng, "2.2222")
    }
}
