// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let backButton = ImageAsset(name: "backButton")
  internal static let closeButton = ImageAsset(name: "closeButton")
  internal static let deleteFromCartButton = ImageAsset(name: "deleteFromCartButton")
  internal static let editButton = ImageAsset(name: "editButton")
  internal static let sortButton = ImageAsset(name: "sortButton")
  internal static let beigeApril = ImageAsset(name: "BeigeApril")
  internal static let beigeAurora = ImageAsset(name: "BeigeAurora")
  internal static let beigeBimbo = ImageAsset(name: "BeigeBimbo")
  internal static let beigeBiscuit = ImageAsset(name: "BeigeBiscuit")
  internal static let beigeBreena = ImageAsset(name: "BeigeBreena")
  internal static let beigeBuster = ImageAsset(name: "BeigeBuster")
  internal static let beigeCorbin = ImageAsset(name: "BeigeCorbin")
  internal static let beigeCupid = ImageAsset(name: "BeigeCupid")
  internal static let beigeDingo = ImageAsset(name: "BeigeDingo")
  internal static let beigeEllsa = ImageAsset(name: "BeigeEllsa")
  internal static let beigeFinn = ImageAsset(name: "BeigeFinn")
  internal static let beigeGus = ImageAsset(name: "BeigeGus")
  internal static let beigeLark = ImageAsset(name: "BeigeLark")
  internal static let beigeLucky = ImageAsset(name: "BeigeLucky")
  internal static let beigeMelvin = ImageAsset(name: "BeigeMelvin")
  internal static let beigeNala = ImageAsset(name: "BeigeNala")
  internal static let beigePenny = ImageAsset(name: "BeigePenny")
  internal static let beigeRalph = ImageAsset(name: "BeigeRalph")
  internal static let beigeSalena = ImageAsset(name: "BeigeSalena")
  internal static let beigeSimba = ImageAsset(name: "BeigeSimba")
  internal static let beigeWhisper = ImageAsset(name: "BeigeWhisper")
  internal static let blueBonnie = ImageAsset(name: "BlueBonnie")
  internal static let blueClover = ImageAsset(name: "BlueClover")
  internal static let blueDiana = ImageAsset(name: "BlueDiana")
  internal static let blueLoki = ImageAsset(name: "BlueLoki")
  internal static let blueOllie = ImageAsset(name: "BlueOllie")
  internal static let brownBitsy = ImageAsset(name: "BrownBitsy")
  internal static let brownCharlie = ImageAsset(name: "BrownCharlie")
  internal static let brownEmma = ImageAsset(name: "BrownEmma")
  internal static let brownIggy = ImageAsset(name: "BrownIggy")
  internal static let brownRosie = ImageAsset(name: "BrownRosie")
  internal static let brownStella = ImageAsset(name: "BrownStella")
  internal static let brownToast = ImageAsset(name: "BrownToast")
  internal static let brownZeus = ImageAsset(name: "BrownZeus")
  internal static let beigeCover = ImageAsset(name: "BeigeCover")
  internal static let blueCover = ImageAsset(name: "BlueCover")
  internal static let brownCover = ImageAsset(name: "BrownCover")
  internal static let grayCover = ImageAsset(name: "GrayCover")
  internal static let greenCover = ImageAsset(name: "GreenCover")
  internal static let peachCover = ImageAsset(name: "PeachCover")
  internal static let pinkCover = ImageAsset(name: "PinkCover")
  internal static let whiteCover = ImageAsset(name: "WhiteCover")
  internal static let yellowCover = ImageAsset(name: "YellowCover")
  internal static let grayArlena = ImageAsset(name: "GrayArlena")
  internal static let grayBethany = ImageAsset(name: "GrayBethany")
  internal static let grayBig = ImageAsset(name: "GrayBig")
  internal static let grayButter = ImageAsset(name: "GrayButter")
  internal static let grayChip = ImageAsset(name: "GrayChip")
  internal static let grayDevin = ImageAsset(name: "GrayDevin")
  internal static let grayDominique = ImageAsset(name: "GrayDominique")
  internal static let grayElliot = ImageAsset(name: "GrayElliot")
  internal static let grayFlash = ImageAsset(name: "GrayFlash")
  internal static let grayGrace = ImageAsset(name: "GrayGrace")
  internal static let grayJosie = ImageAsset(name: "GrayJosie")
  internal static let grayKaydan = ImageAsset(name: "GrayKaydan")
  internal static let grayLanka = ImageAsset(name: "GrayLanka")
  internal static let grayLarson = ImageAsset(name: "GrayLarson")
  internal static let grayLipton = ImageAsset(name: "GrayLipton")
  internal static let grayPiper = ImageAsset(name: "GrayPiper")
  internal static let grayRocky = ImageAsset(name: "GrayRocky")
  internal static let grayTucker = ImageAsset(name: "GrayTucker")
  internal static let grayZac = ImageAsset(name: "GrayZac")
  internal static let greenGwen = ImageAsset(name: "GreenGwen")
  internal static let greenLina = ImageAsset(name: "GreenLina")
  internal static let greenMelissa = ImageAsset(name: "GreenMelissa")
  internal static let greenSpring = ImageAsset(name: "GreenSpring")
  internal static let peachArchie = ImageAsset(name: "PeachArchie")
  internal static let peachArt = ImageAsset(name: "PeachArt")
  internal static let peachBiscuit = ImageAsset(name: "PeachBiscuit")
  internal static let peachDaisy = ImageAsset(name: "PeachDaisy")
  internal static let peachNacho = ImageAsset(name: "PeachNacho")
  internal static let peachOreo = ImageAsset(name: "PeachOreo")
  internal static let peachPixi = ImageAsset(name: "PeachPixi")
  internal static let peachRuby = ImageAsset(name: "PeachRuby")
  internal static let peachSusan = ImageAsset(name: "PeachSusan")
  internal static let peachTater = ImageAsset(name: "PeachTater")
  internal static let peachZoe = ImageAsset(name: "PeachZoe")
  internal static let pinkAriana = ImageAsset(name: "PinkAriana")
  internal static let pinkCalder = ImageAsset(name: "PinkCalder")
  internal static let pinkCashew = ImageAsset(name: "PinkCashew")
  internal static let pinkCharity = ImageAsset(name: "PinkCharity")
  internal static let pinkFlower = ImageAsset(name: "PinkFlower")
  internal static let pinkJerry = ImageAsset(name: "PinkJerry")
  internal static let pinkLilo = ImageAsset(name: "PinkLilo")
  internal static let pinkLucy = ImageAsset(name: "PinkLucy")
  internal static let pinkMilo = ImageAsset(name: "PinkMilo")
  internal static let pinkMoose = ImageAsset(name: "PinkMoose")
  internal static let pinkOscar = ImageAsset(name: "PinkOscar")
  internal static let pinkPatton = ImageAsset(name: "PinkPatton")
  internal static let pinkRufus = ImageAsset(name: "PinkRufus")
  internal static let pinkSalena = ImageAsset(name: "PinkSalena")
  internal static let whiteArielle = ImageAsset(name: "WhiteArielle")
  internal static let whiteBarney = ImageAsset(name: "WhiteBarney")
  internal static let whiteIron = ImageAsset(name: "WhiteIron")
  internal static let whiteLogan = ImageAsset(name: "WhiteLogan")
  internal static let whiteLumpy = ImageAsset(name: "WhiteLumpy")
  internal static let whitePaddy = ImageAsset(name: "WhitePaddy")
  internal static let whiteVulcan = ImageAsset(name: "WhiteVulcan")
  internal static let yellowFlorine = ImageAsset(name: "YellowFlorine")
  internal static let yellowHelga = ImageAsset(name: "YellowHelga")
  internal static let yellowLuna = ImageAsset(name: "YellowLuna")
  internal static let yellowMowgli = ImageAsset(name: "YellowMowgli")
  internal static let yellowOlaf = ImageAsset(name: "YellowOlaf")
  internal static let yellowPumpkin = ImageAsset(name: "YellowPumpkin")
  internal static let yellowWillow = ImageAsset(name: "YellowWillow")
  internal static let yellowWinnie = ImageAsset(name: "YellowWinnie")
  internal static let ratingActive = ImageAsset(name: "ratingActive")
  internal static let ratingInactive = ImageAsset(name: "ratingInactive")
  internal static let catalog = ImageAsset(name: "Catalog")
  internal static let profile = ImageAsset(name: "Profile")
  internal static let logo = ImageAsset(name: "logo")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

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
