import Foundation

struct GetFavoritesRequest: NetworkRequest {
    var endpoint: URL? {
        NetworkConstants.baseUrl.appendingPathComponent("/profile/1")
    }
}
