import Foundation

struct ProfileDto: Encodable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let likes: [String]
}
