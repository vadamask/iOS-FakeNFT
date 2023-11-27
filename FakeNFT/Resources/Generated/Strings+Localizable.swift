// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Закрыть
  internal static let close = L10n.tr("Localizable", "close", fallback: "Закрыть")
  internal enum Catalog {
    /// По названию
    internal static let sortByName = L10n.tr("Localizable", "Catalog.sortByName", fallback: "По названию")
    /// По количеству NFT
    internal static let sortByNftCount = L10n.tr("Localizable", "Catalog.sortByNftCount", fallback: "По количеству NFT")
    /// Сортировка
    internal static let sorting = L10n.tr("Localizable", "Catalog.sorting", fallback: "Сортировка")
  }
  internal enum Onboarding {
    /// Что внутри?
    internal static let button = L10n.tr("Localizable", "Onboarding.button", fallback: "Что внутри?")
    /// Присоединяйтесь и откройте новый мир уникальных NFT для коллекционеров
    internal static let description1 = L10n.tr("Localizable", "Onboarding.description1", fallback: "Присоединяйтесь и откройте новый мир уникальных NFT для коллекционеров")
    /// Пополняйте свою коллекцию эксклюзивными картинками, созданными нейросетью!
    internal static let description2 = L10n.tr("Localizable", "Onboarding.description2", fallback: "Пополняйте свою коллекцию эксклюзивными картинками, созданными нейросетью!")
    /// Смотрите статистику других и покажите всем, что у вас самая ценная коллекция
    internal static let description3 = L10n.tr("Localizable", "Onboarding.description3", fallback: "Смотрите статистику других и покажите всем, что у вас самая ценная коллекция")
    /// Исследуйте
    internal static let title1 = L10n.tr("Localizable", "Onboarding.title1", fallback: "Исследуйте")
    /// Коллекционируйте
    internal static let title2 = L10n.tr("Localizable", "Onboarding.title2", fallback: "Коллекционируйте")
    /// Состязайтесь
    internal static let title3 = L10n.tr("Localizable", "Onboarding.title3", fallback: "Состязайтесь")
  }
  internal enum Sort {
    /// По имени
    internal static let byName = L10n.tr("Localizable", "Sort.byName", fallback: "По имени")
    /// По рейтингу
    internal static let byRating = L10n.tr("Localizable", "Sort.byRating", fallback: "По рейтингу")
    /// Закрыть
    internal static let close = L10n.tr("Localizable", "Sort.close", fallback: "Закрыть")
    /// Сортировка
    internal static let title = L10n.tr("Localizable", "Sort.title", fallback: "Сортировка")
  }
  internal enum Tab {
    /// Корзина
    internal static let cart = L10n.tr("Localizable", "Tab.cart", fallback: "Корзина")
    /// Каталог
    internal static let catalog = L10n.tr("Localizable", "Tab.catalog", fallback: "Каталог")
    /// Статистика
    internal static let statistics = L10n.tr("Localizable", "Tab.statistics", fallback: "Статистика")
  }
  internal enum User {
    /// Коллекция NFT
    internal static let nftCollection = L10n.tr("Localizable", "User.nftCollection", fallback: "Коллекция NFT")
    /// У пользователя нет NFT
    internal static let noNftError = L10n.tr("Localizable", "User.noNftError", fallback: "У пользователя нет NFT")
    /// Перейти на сайт пользователя
    internal static let visitWebSite = L10n.tr("Localizable", "User.visitWebSite", fallback: "Перейти на сайт пользователя")
  }
  internal enum Cart {
    internal enum DeleteScreen {
      /// Вы уверены, что хотите удалить объект из корзины?
      internal static let approveDelete = L10n.tr("Localizable", "cart.delete_screen.approveDelete", fallback: "Вы уверены, что хотите удалить объект из корзины?")
      /// Удалить
      internal static let delete = L10n.tr("Localizable", "cart.delete_screen.delete", fallback: "Удалить")
      /// Вернуться
      internal static let goBack = L10n.tr("Localizable", "cart.delete_screen.goBack", fallback: "Вернуться")
    }
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
  internal enum Error {
    /// Отменить
    internal static let cancel = L10n.tr("Localizable", "error.cancel", fallback: "Отменить")
    /// Невозможно прочитать JSON файл
    internal static let errorJsonLoad = L10n.tr("Localizable", "error.errorJsonLoad", fallback: "Невозможно прочитать JSON файл")
    /// Не удалось произвести оплату
    internal static let insufficientFunds = L10n.tr("Localizable", "error.insufficientFunds", fallback: "Не удалось произвести оплату")
    /// Неправильный запрос
    internal static let invalidRequest = L10n.tr("Localizable", "error.invalidRequest", fallback: "Неправильный запрос")
    /// Произошла ошибка сети
    internal static let network = L10n.tr("Localizable", "error.network", fallback: "Произошла ошибка сети")
    /// Ок
    internal static let ok = L10n.tr("Localizable", "error.ok", fallback: "Ок")
    /// Parsing error: Ошибка при обработке данных с сервера
    internal static let parsingError = L10n.tr("Localizable", "error.parsingError", fallback: "Parsing error: Ошибка при обработке данных с сервера")
    /// Повторить
    internal static let `repeat` = L10n.tr("Localizable", "error.repeat", fallback: "Повторить")
    /// Ошибка
    internal static let title = L10n.tr("Localizable", "error.title", fallback: "Ошибка")
    /// Не удалось загрузить данные
    internal static let unableToLoad = L10n.tr("Localizable", "error.unableToLoad", fallback: "Не удалось загрузить данные")
    /// Произошла неизвестная ошибка
    internal static let unknown = L10n.tr("Localizable", "error.unknown", fallback: "Произошла неизвестная ошибка")
    /// UrlSessionError: Произошла ошибка при соединении
    internal static let urlSessionError = L10n.tr("Localizable", "error.urlSessionError", fallback: "UrlSessionError: Произошла ошибка при соединении")
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
