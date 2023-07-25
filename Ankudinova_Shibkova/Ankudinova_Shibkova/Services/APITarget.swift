import Foundation
import Moya

enum APITarget {
    case getCharacters
}

extension APITarget: TargetType {
    var baseURL : URL {
        guard let url = URL(string: "https://rickandmortyapi.com/api") else {
            fatalError("Cannot get url")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
