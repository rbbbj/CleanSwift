import RealmSwift
import Realm

final class RMUser: Object {
    var id = RealmOptional<Int>()
    @objc dynamic var name: String?
    @objc dynamic var username: String?
    @objc dynamic var email: String?
    @objc dynamic var phone: String?
    @objc dynamic var website: String?
    @objc dynamic var address: RMAddress?
    @objc dynamic var company: RMCompany?

    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(from user: User) {
        self.init()
        
        self.id.value = user.id
        self.name = user.name
        self.username = user.username
        self.email = user.email
        self.phone = user.phone
        self.website = user.website
        self.address = user.address?.asRealm()
        self.company = user.company?.asRealm()
    }
}

extension RMUser {
    func asDomain() throws -> User { return try User(from: self) }
}
