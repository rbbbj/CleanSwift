struct Address {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Location?

    init(street: String,
         suite: String,
         city: String,
         zipcode: String,
         geo: Location) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
    
    init(from response: AddressResponse) throws {
        self.street = response.street
        self.suite = response.suite
        self.city = response.city
        self.zipcode = response.zipcode
        guard let lat = (response.geo?.lat), let lng = (response.geo?.lng) else {
            throw CustomError.dataError
        }
        self.geo = Location(lat: lat, lng: lng)
    }

    init(from entity: RMAddress) throws {
        guard let street = entity.street,
            let suite = entity.suite,
            let city = entity.city,
            let zipcode = entity.zipcode,
            let geo = try entity.geo?.asDomain() else {
                throw CustomError.dataError
        }

        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
}

extension Address {
    func asRealm() -> RMAddress { return RMAddress(from: self) }
}
