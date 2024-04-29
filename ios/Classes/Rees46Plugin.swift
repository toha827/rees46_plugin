import Flutter
import UIKit
import REES46

public class Rees46Plugin: NSObject, FlutterPlugin, Rees46Sender {
    var sdk: PersonalizationSDK?;
    
    func initialize(shopID: String, apiDomain: String?) throws {
        do {
            sdk = createPersonalizationSDK(shopId: shopID, apiDomain: apiDomain ?? "api.rees46.ru", stream: "ios", enableLogs: true)
        } catch {
            print(error)
        }
    }
    
    func track(trackEvent: String, itemID: String) throws {
        var trackEventType: Event;
        switch (trackEvent) {
        case "VIEW":
            trackEventType = .productView(id: itemID)
            break;
//        case "WISH":
//            trackEventType = .productAddedToFavorities(id: itemID)
//            break;
        default:
            return;
        }
        
        sdk!.track(event: trackEventType) { trackResponse in
            print("Product viewed callback")
            switch trackResponse {
            case let .success(response):
                print("Successful")
            case let .failure(error):
                print("Error: ", error)
                switch error {
                case .custom(let customError):
                    print("Error: ", customError)
                default:
                    print("Error: ", error.localizedDescription)
                }
            }
        }
    }
    
    func recommend(recommenderCode: String, extended: Bool, itemID: String, categoryID: String, completion: @escaping (Result<[String]?, any Error>) -> Void) {

        do {
            sdk!.recommend(blockId: recommenderCode) { result in
                switch result {
                    case .success(let response):
                        // Handle the successful response
                        print("Recommendations received: \(response.title)")
                        for recommendation in response.recommended {
                            print("\(recommendation.name) with ID \(recommendation.id)")
                        }
                    case .failure(let error):
                        // Handle the error
                        print("Failed to fetch recommendations: \(error)")
                    }
            }
        } catch {
            print(error)
        }
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "rees46_plugin", binaryMessenger: registrar.messenger())
    let instance = Rees46Plugin()
    let messenger : FlutterBinaryMessenger = registrar.messenger()
    registrar.addMethodCallDelegate(instance, channel: channel)
    let api : Rees46Sender & NSObjectProtocol = Rees46Plugin.init()
    Rees46SenderSetup.setUp(binaryMessenger: messenger, api: api)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
