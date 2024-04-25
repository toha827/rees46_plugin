import 'package:pigeon/pigeon.dart';

enum TrackEvent {
  view,
  category,
  cart,
  remove_from_cart,
  purchase,
  search,
  wish,
  remove_wish,
}

/// FLUTTER FRAMEWORK -> FLUTTER ENGINE
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/rees46_plugin.g.dart',
  kotlinOut:
      'android/src/main/kotlin/kz/rees46/sdk/rees46_plugin/Rees46Plugin.g.kt',
  swiftOut: 'ios/Runner/Rees46Plugin.g.swift',
  javaOptions: JavaOptions(package: 'kz.rees46.sdk.rees46_plugin'),
  dartPackageName: 'rees64_plugin',
))
@HostApi()
abstract class Rees46Sender {
  void initialize(String shopID, String apiDomain);

  void track(String trackEvent, String itemID);

  void recommend(String recommenderCode, bool extended, String itemID, String categoryID);
}

/// FLUTTER FRAMEWORK <- FLUTTER ENGINE
@FlutterApi()
abstract class Rees46Receiver {
  // void onTick(TickerMessage tickerMessage);
}