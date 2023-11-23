import Foundation

enum NetworkConstants {
    static let baseURL = URL(string: "https://65450ba25a0b4b04436d87b8.mockapi.io/api/v1")!
    static let profileEndpoint = "profile/1"
    static let linkYandexPracticum = "https://practicum.yandex.ru/ios-developer"
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkRequest {
    var endpoint: URL? { get }
    var httpMethod: HttpMethod { get }
    var dto: Encodable? { get }
}

// default values
extension NetworkRequest {
    var httpMethod: HttpMethod { .get }
    var dto: Encodable? { nil }
}
