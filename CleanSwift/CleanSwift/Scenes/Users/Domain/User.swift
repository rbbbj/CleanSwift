struct User {
    private(set) var id: Int?
    private(set) var name: String?
    private(set) var username: String?
    private(set) var email: String?
    private(set) var phone: String?
    private(set) var website: String?
    private(set) var address: Address?
    private(set) var company: Company?

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
    
    init(from response: UserResponse) throws {
        guard let geo = response.address?.geo,
              let lat = geo.lat,
              let lng = geo.lng else {
            throw CustomError.dataError
        }
        let location = Location(lat: lat, lng: lng)
        
        guard let street = response.address?.street,
              let suite = response.address?.suite,
              let city = response.address?.city,
              let zipcode = response.address?.zipcode else {
            throw CustomError.dataError
        }
        let address = Address(street: street, suite: suite, city: city, zipcode: zipcode, geo: location)
        
        guard let name = response.company?.name,
              let catchPhrase = response.company?.catchPhrase,
              let bs = response.company?.bs else {
            
            throw CustomError.dataError
        }
        let company = Company(name: name, catchPhrase: catchPhrase, bs: bs)
        
        self.id = response.id
        self.name = response.name
        self.username = response.username
        self.email = response.email
        self.phone = response.phone
        self.website = response.website
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

//MARK: - Mapping

extension User {
    func asRealm() -> RMUser { return RMUser(from: self) }
}

//MARK: - Helpers

extension User {
    mutating func set(phone newPhone: String) {
        phone = newPhone
    }
    
    mutating func set(address newAddress: Address) {
        address = newAddress
    }
}