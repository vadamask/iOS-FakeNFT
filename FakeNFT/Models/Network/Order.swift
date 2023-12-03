import Foundation

struct Order: Decodable {
    let id: String
    let nfts: [String]
}
