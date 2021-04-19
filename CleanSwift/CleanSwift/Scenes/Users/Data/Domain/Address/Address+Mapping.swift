extension Address: Decodable {
    private enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        street = try container.decodeIfPresent(String.self, forKey: .street)
        suite = try container.decodeIfPresent(String.self, forKey: .suite)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        zipcode = try container.decodeIfPresent(String.self, forKey: .zipcode)
        geo = try container.decode(Location.self, forKey: .geo)
    }
}

