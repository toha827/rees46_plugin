import 'package:pigeon/pigeon.dart';

enum TrackEvent {
  view,
  category,
  cart,
  remove_from_cart,
  purchase, // добавлен, но не реализован в iOS/Android
  search,
  wish,
  remove_wish,
}

/// FLUTTER FRAMEWORK -> FLUTTER ENGINE
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/rees46_plugin.g.dart',
  kotlinOut:
      'android/src/main/kotlin/kz/rees46/sdk/rees46_plugin/Rees46Plugin.g.kt',
  swiftOut: 'ios/Classes/Rees46Plugin.g.swift',
  objcHeaderOut: 'ios/Classes/Rees46Plugin.g.h',
  objcSourceOut: 'ios/Classes/Rees46Plugin.g.m',
  javaOptions: JavaOptions(package: 'kz.rees46.sdk.rees46_plugin'),
  dartPackageName: 'rees46_plugin', 
))
@HostApi()
abstract class Rees46Sender {
  @async 
  void initialize(String shopID, String? apiDomain);

  @async 
  void track(
    String trackEvent,
    String itemID, {
    int? amount,
  });

  @async
  List<String>? recommend(
    String recommenderCode,
    bool extended,
    String itemID,
    String categoryID,
  );

  @async 
  void setProfile(
    String userId,
    String email,
    String phone,
  );
}

/// FLUTTER FRAMEWORK <- FLUTTER ENGINE
@FlutterApi()
abstract class Rees46Receiver {

}