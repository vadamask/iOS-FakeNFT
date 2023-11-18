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
    /// Произошла ошибка сети
    internal static let network = L10n.tr("Localizable", "Error.network", fallback: "Произошла ошибка сети")
    /// Повторить
    internal static let `repeat` = L10n.tr("Localizable", "Error.repeat", fallback: "Повторить")
    /// Ошибка
    internal static let title = L10n.tr("Localizable", "Error.title", fallback: "Ошибка")
    /// Произошла неизвестная ошибка
    internal static let unknown = L10n.tr("Localizable", "Error.unknown", fallback: "Произошла неизвестная ошибка")
  }
  internal enum Profile {
    /// О разработчике
    internal static let aboutDeveloper = L10n.tr("Localizable", "Profile.aboutDeveloper", fallback: "О разработчике")
    /// Сменить фото
    internal static let changePhoto = L10n.tr("Localizable", "Profile.changePhoto", fallback: "Сменить фото")
    /// Описание
    internal static let description = L10n.tr("Localizable", "Profile.description", fallback: "Описание")
    /// У Вас ещё нет избранных NFT
    internal static let emptyFavouriteNFTLabel = L10n.tr("Localizable", "Profile.emptyFavouriteNFTLabel", fallback: "У Вас ещё нет избранных NFT")
    /// У вас ещё нет NFT
    internal static let emptyNFTLabel = L10n.tr("Localizable", "Profile.emptyNFTLabel", fallback: "У вас ещё нет NFT")
    /// Загрузить изображение
    internal static let loadPicture = L10n.tr("Localizable", "Profile.loadPicture", fallback: "Загрузить изображение")
    /// Мои NFT
    internal static let myNFT = L10n.tr("Localizable", "Profile.myNFT", fallback: "Мои NFT")
    /// Избранные NFT
    internal static let nftFavorites = L10n.tr("Localizable", "Profile.NFTFavorites", fallback: "Избранные NFT")
    /// Нет интернета
    internal static let noInternet = L10n.tr("Localizable", "Profile.noInternet", fallback: "Нет интернета")
    /// Имя
    internal static let username = L10n.tr("Localizable", "Profile.username", fallback: "Имя")
    /// Сайт
    internal static let website = L10n.tr("Localizable", "Profile.website", fallback: "Сайт")
  }
  internal enum Tab {
    /// Каталог
    internal static let catalog = L10n.tr("Localizable", "Tab.catalog", fallback: "Каталог")
    /// Профиль
    internal static let profile = L10n.tr("Localizable", "Tab.profile", fallback: "Профиль")
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
