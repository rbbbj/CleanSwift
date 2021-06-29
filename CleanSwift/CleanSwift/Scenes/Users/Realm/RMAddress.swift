import RealmSwift
import Realm

final class RMAddress: Object {
    @objc dynamic var street: String?
    @objc dynamic var suite: String?
    @objc dynamic var city: String?
    @objc dynamic var zipcode: String?
    @objc dynamic var geo: RMLocation?
    
    convenience init(from adress: Address) {
        self.init()
        
        self.street = adress.street
        self.suite = adress.suite
        self.city = adress.city
        self.zipcode = adress.zipcode
        self.geo = adress.geo.asRealm()
    }
}

extension RMAddress {
    func asDomain() throws -> Address { return try Address(from: self) }
}
