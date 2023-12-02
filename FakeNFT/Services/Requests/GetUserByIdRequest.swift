import Foundation

struct GetUserByIdRequest: NetworkRequest {
    var endpoint: URL? {
        NetworkConstants.baseUrl.appendingPathComponent("/users/\(id)")
    }
    
    private let id: String
    
    init(id: String) {
        self.id = id
    }
}
