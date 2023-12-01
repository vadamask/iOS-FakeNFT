import Foundation
// Расширение для безопасного использования String значений в URL (пробелы, спецсимволы и символы используются правильно)
extension String {
    var encodeUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
}
