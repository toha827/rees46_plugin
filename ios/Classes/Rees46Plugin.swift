import Flutter
import UIKit
import REES46

public class Rees46Plugin: NSObject, FlutterPlugin, Rees46Sender {
    var sdk: PersonalizationSDK?;
    
    func initialize(shopID: String, apiDomain: String?, token: String?) throws {
        do {
            sdk = createPersonalizationSDK(shopId: shopID, apiDomain: apiDomain ?? "api.rees46.ru", stream: "ios", enableLogs: true)
            
            sdk.setPushTokenNotification(token: token) { (tokenResponse) in
                print("Token set response")
              }
        } catch {
            print(error)
        }
    }
    
    func track(trackEvent: String, itemID: String, amount: Int64?) throws {
        var trackEventType: Event;
        switch (trackEvent.lowercased()) {
        case "view":
            trackEventType = .productView(id: itemID)
            break;
        case "wish":
            trackEventType = .productAddedToFavorities(id: itemID)
            break;
        case "category":
            trackEventType = .categoryView(id: itemID)
            break;
//        case "search":
//            trackEventType = .search(query: itemID)
//            break;
        case "cart":
            trackEventType = .productAddedToCart(id: itemID)
            break;
        case "remove_from_cart":
            trackEventType = .productRemovedFromCart(id: itemID)
            break;
        case "remove_from_wish":
            trackEventType = .productRemovedToFavorities(id: itemID)
            break;
        default:
            return;
        }
        
        do {
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
        } catch {
            print("Track error \(error)")
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
                        completion(Result.success(response.recommended.map({ it in
                            it.id
                        })))
                    case .failure(let error):
                        // Handle the error
                        print("Failed to fetch recommendations: \(error)")
                    }
            }
        } catch {
            print(error)
        }
    }
    
    func setProfile(userId: String, email: String, phone: String) throws {
        do {sdk!.setProfileData(userEmail: email,
                                userPhone: phone,
                                userLoyaltyId: userId
//                                birthday: ...,
//                                age: ...,
//                                firstName: ...,
//                                lastName: ...,
//                                location: ...,
//                                gender: ...
        ) { (profileDataResp) in
            print("Profile data callback")
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