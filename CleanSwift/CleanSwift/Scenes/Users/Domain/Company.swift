struct Company {
    let name: String?
    let catchPhrase: String?
    let bs: String?
    
    init(name: String,
         catchPhrase: String,
         bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
    
    init(from response: CompanyResponse) {
        self.name = response.name
        self.catchPhrase = response.catchPhrase
        self.bs = response.bs
    }

    init(from entity: RMCompany) throws {
        guard let name = entity.name,
            let catchPhrase = entity.catchPhrase,
            let bs = entity.bs else {
                throw CustomError.dataError
        }

        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}

extension Company {
    func asRealm() -> RMCompany { return RMCompany(from: self) }
}
