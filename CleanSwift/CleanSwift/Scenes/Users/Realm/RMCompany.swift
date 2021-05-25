import RealmSwift
import Realm

final class RMCompany: Object {
    @objc dynamic var name: String?
    @objc dynamic var catchPhrase: String?
    @objc dynamic var bs: String?
    
    convenience init(from company: Company) {
        self.init()
        
        self.name = company.name
        self.catchPhrase = company.catchPhrase
        self.bs = company.bs
    }
}

extension RMCompany {
    func asDomain() throws -> Company { return try Company(from: self) }
}
