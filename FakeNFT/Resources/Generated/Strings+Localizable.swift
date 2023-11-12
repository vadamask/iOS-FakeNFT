// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Catalog {
    /// Открыть Nft
    internal static let openNft = L10n.tr("Localizable", "Catalog.openNft", fallback: "Открыть Nft")
  }
  internal enum Error {
    /// Отменить
    internal static let cancel = L10n.tr("Localizable", "Error.cancel", fallback: "Отменить")
    /// Не удалось произвести оплату
    internal static let insufficientFunds = L10n.tr("Localizable", "Error.insufficientFunds", fallback: "Не удалось произвести оплату")
    /// Произошла ошибка сети
    internal static let network = L10n.tr("Localizable", "Error.network", fallback: "Произошла ошибка сети")
    /// Ок
    internal static let ok = L10n.tr("Localizable", "Error.ok", fallback: "Ок")
    /// Повторить
    internal static let `repeat` = L10n.tr("Localizable", "Error.repeat", fallback: "Повторить")
    /// Ошибка
    internal static let title = L10n.tr("Localizable", "Error.title", fallback: "Ошибка")
    /// Произошла неизвестная ошибка
    internal static let unknown = L10n.tr("Localizable", "Error.unknown", fallback: "Произошла неизвестная ошибка")
  }
  internal enum Tab {
    /// Корзина
    internal static let cart = L10n.tr("Localizable", "Tab.cart", fallback: "Корзина")
    /// Каталог
    internal static let catalog = L10n.tr("Localizable", "Tab.catalog", fallback: "Каталог")
  }
  internal enum Cart {
    internal enum MainScreen {
      /// К оплате
      internal static let buyNft = L10n.tr("Localizable", "cart.main_screen.buyNft", fallback: "К оплате")
      /// Корзина пуста
      internal static let emptyState = L10n.tr("Localizable", "cart.main_screen.empty_state", fallback: "Корзина пуста")
      /// Цена
      internal static let price = L10n.tr("Localizable", "cart.main_screen.price", fallback: "Цена")
      internal enum AlertController {
        /// Закрыть
        internal static let close = L10n.tr("Localizable", "cart.main_screen.alert_controller.close", fallback: "Закрыть")
        /// Сортировка
        internal static let title = L10n.tr("Localizable", "cart.main_screen.alert_controller.title", fallback: "Сортировка")
      }
      internal enum SortOption {
        /// По названию
        internal static let name = L10n.tr("Localizable", "cart.main_screen.sort_option.name", fallback: "По названию")
        /// По цене
        internal static let price = L10n.tr("Localizable", "cart.main_screen.sort_option.price", fallback: "По цене")
        /// По рейтингу
        internal static let rating = L10n.tr("Localizable", "cart.main_screen.sort_option.rating", fallback: "По рейтингу")
      }
    }
    internal enum PaymentScreen {
      /// Оплатить
      internal static let payButton = L10n.tr("Localizable", "cart.payment_screen.pay_button", fallback: "Оплатить")
      /// Совершая покупку, вы соглашаетесь с условиями
      /// Пользовательского соглашения
      internal static let terms = L10n.tr("Localizable", "cart.payment_screen.terms", fallback: "Совершая покупку, вы соглашаетесь с условиями\nПользовательского соглашения")
      /// Выберите способ оплаты
      internal static let topBarTitle = L10n.tr("Localizable", "cart.payment_screen.top_bar_title", fallback: "Выберите способ оплаты")
    }
    internal enum SuccessfulPayment {
      /// Вернуться в каталог
      internal static let backToCatatlog = L10n.tr("Localizable", "cart.successful_payment.backToCatatlog", fallback: "Вернуться в каталог")
      /// Успех! Оплата прошла, поздравляем с покупкой!
      internal static let label = L10n.tr("Localizable", "cart.successful_payment.label", fallback: "Успех! Оплата прошла, поздравляем с покупкой!")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
