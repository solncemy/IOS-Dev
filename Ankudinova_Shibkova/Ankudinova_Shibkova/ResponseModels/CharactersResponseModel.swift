import Foundation

struct Welcome: Codable {
    let info: Info
    let results: [CharacterResponseModel]
}

struct Info: Codable {
    let count, pages: Int
    let next: String
    let prev: JSONNull?
}

struct CharacterResponseModel: Codable {
    let id: Int
    var name: String
    var status: Status
    var species: Species
    var type: String
    var gender: Gender
    var origin, location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

struct Location: Codable {
    var name: String
    var url: String
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}


class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
