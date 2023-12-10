import Foundation

struct Currency: Hashable & Decodable {
    let id: String
    let title: String
    let name: String
    let image: String
}
