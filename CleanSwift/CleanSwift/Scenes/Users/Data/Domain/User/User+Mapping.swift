extension User: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case phone
        case website
        case address
        case company
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        address = try container.decode(Address.self, forKey: .address)
        company = try container.decode(Company.self, forKey: .company)
    }
}
