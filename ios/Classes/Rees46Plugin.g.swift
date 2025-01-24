// Autogenerated from Pigeon (v18.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

enum TrackEvent: Int {
  case view = 0
  case category = 1
  case cart = 2
  case removeFromCart = 3
  case purchase = 4
  case search = 5
  case wish = 6
  case removeWish = 7
}

/// FLUTTER FRAMEWORK -> FLUTTER ENGINE
///
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol Rees46Sender {
  func initialize(shopID: String, apiDomain: String?, token: String?) throws
  func track(trackEvent: String, itemID: String, amount: Int64?) throws
  func recommend(recommenderCode: String, extended: Bool, itemID: String, categoryID: String, completion: @escaping (Result<[String]?, Error>) -> Void)
  func setProfile(userId: String, email: String, phone: String) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class Rees46SenderSetup {
  /// The codec used by Rees46Sender.
  /// Sets up an instance of `Rees46Sender` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: Rees46Sender?, messageChannelSuffix: String = "") {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    let initializeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.rees64_plugin.Rees46Sender.initialize\(channelSuffix)", binaryMessenger: binaryMessenger)
    if let api = api {
      initializeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let shopIDArg = args[0] as! String
        let apiDomainArg: String? = nilOrValue(args[1])
        let tokenArg: String? = nilOrValue(args[2])
        do {
          try api.initialize(shopID: shopIDArg, apiDomain: apiDomainArg, token: tokenArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      initializeChannel.setMessageHandler(nil)
    }
    let trackChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.rees64_plugin.Rees46Sender.track\(channelSuffix)", binaryMessenger: binaryMessenger)
    if let api = api {
      trackChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let trackEventArg = args[0] as! String
        let itemIDArg = args[1] as! String
        let amountArg: Int64? = isNullish(args[2]) ? nil : (args[2] is Int64? ? args[2] as! Int64? : Int64(args[2] as! Int32))
        do {
          try api.track(trackEvent: trackEventArg, itemID: itemIDArg, amount: amountArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      trackChannel.setMessageHandler(nil)
    }
    let recommendChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.rees64_plugin.Rees46Sender.recommend\(channelSuffix)", binaryMessenger: binaryMessenger)
    if let api = api {
      recommendChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let recommenderCodeArg = args[0] as! String
        let extendedArg = args[1] as! Bool
        let itemIDArg = args[2] as! String
        let categoryIDArg = args[3] as! String
        api.recommend(recommenderCode: recommenderCodeArg, extended: extendedArg, itemID: itemIDArg, categoryID: categoryIDArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      recommendChannel.setMessageHandler(nil)
    }
    let setProfileChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.rees64_plugin.Rees46Sender.setProfile\(channelSuffix)", binaryMessenger: binaryMessenger)
    if let api = api {
      setProfileChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let userIdArg = args[0] as! String
        let emailArg = args[1] as! String
        let phoneArg = args[2] as! String
        do {
          try api.setProfile(userId: userIdArg, email: emailArg, phone: phoneArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setProfileChannel.setMessageHandler(nil)
    }
  }
}
/// FLUTTER FRAMEWORK <- FLUTTER ENGINE
///
/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol Rees46ReceiverProtocol {
}
class Rees46Receiver: Rees46ReceiverProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  private let messageChannelSuffix: String
  init(binaryMessenger: FlutterBinaryMessenger, messageChannelSuffix: String = "") {
    self.binaryMessenger = binaryMessenger
    self.messageChannelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
  }
}
