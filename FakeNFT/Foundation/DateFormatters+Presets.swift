import Foundation

//Расширение для создания одного экземпляра DateFormatter для дальнейшего использования в операциях форматирования даты и времени
extension DateFormatter {
    static var defaultDateFormatter: ISO8601DateFormatter = ISO8601DateFormatter()
}
