import Foundation

struct OrderPayment: Decodable {
    let success: Bool
    let id: String
    let orderId: String
}
