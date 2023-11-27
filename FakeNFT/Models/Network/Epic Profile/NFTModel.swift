import Foundation

struct NFTModel: Decodable {
    let id: String
    let name: String
    let images: [URL]
    let rating: Int
    let description: String
    let price: Double
    let author: String
    let createdAt: String
}
