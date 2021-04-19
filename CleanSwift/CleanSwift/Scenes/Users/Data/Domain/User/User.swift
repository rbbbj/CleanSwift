struct User {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    let address: Address?
    let company: Company?

    init(id: Int,
         name: String,
         username: String,
         email: String,
         phone: String,
         website: String,
         address: Address,
         company: Company) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
        self.address = address
        self.company = company
    }
    
    init(from entity: RMUser) throws {
        guard let id = entity.id.value,
            let name = entity.name,
            let username = entity.username,
            let email = entity.email,
            let phone = entity.phone,
            let website = entity.website,
            let address = try entity.address?.asDomain(),
            let company = try entity.company?.asDomain() else {
                throw CustomError.dataError
        }
        
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
        self.address = address
        self.company = company
    }
}

extension User {
    func asRealm() -> RMUser { return RMUser(from: self) }
}
