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
    /// Открыть Nft
    internal static let openNft = L10n.tr("Localizable", "Catalog.openNft", fallback: "Открыть Nft")
    /// По названию
    internal static let sortByName = L10n.tr("Localizable", "Catalog.sortByName", fallback: "По названию")
    /// По количеству NFT
    internal static let sortByNftCount = L10n.tr("Localizable", "Catalog.sortByNftCount", fallback: "По количеству NFT")
    /// Сортировка
    internal static let sorting = L10n.tr("Localizable", "Catalog.sorting", fallback: "Сортировка")
  }
  internal enum Error {
    /// Произошла ошибка сети
    internal static let network = L10n.tr("Localizable", "Error.network", fallback: "Произошла ошибка сети")
    /// Повторить
    internal static let `repeat` = L10n.tr("Localizable", "Error.repeat", fallback: "Повторить")
    /// Ошибка
    internal static let title = L10n.tr("Localizable", "Error.title", fallback: "Ошибка")
    /// Не удалось загрузить данные
    internal static let unableToLoad = L10n.tr("Localizable", "Error.unableToLoad", fallback: "Не удалось загрузить данные")
    /// Произошла неизвестная ошибка
    internal static let unknown = L10n.tr("Localizable", "Error.unknown", fallback: "Произошла неизвестная ошибка")
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
  internal enum Tab {
    /// Каталог
    internal static let catalog = L10n.tr("Localizable", "Tab.catalog", fallback: "Каталог")
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
