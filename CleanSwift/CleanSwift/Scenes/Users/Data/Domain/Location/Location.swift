struct Location {
    let lat: String?
    let lng: String?
    
    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
    
    init(from entity: RMLocation) throws {
        guard let lat = entity.lat,
            let lng = entity.lng else {
                throw CustomError.dataError
        }
        
        self.lat = lat
        self.lng = lng
    }
}

extension Location {
    func asRealm() -> RMLocation { return RMLocation(from: self) }
}
