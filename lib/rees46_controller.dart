import 'rees46_plugin.g.dart';

abstract class IRees46Controller {
  void initialize(String shopID, String? apiDomain);

  void track(String trackEvent, String itemID);

  void recommend(
      String recommenderCode, bool extended, String itemID, String categoryID);
}

class Rees46Controller implements IRees46Controller, Rees46Receiver {
  static Rees46Controller? _instance;

  factory Rees46Controller.instance() => _instance ?? Rees46Controller._();

  Rees46Controller._() : _sink = Rees46Sender() {
    Rees46Receiver.setUp(this);
  }

  final Rees46Sender _sink;

  @override
  void initialize(String shopID, String? apiDomain) => _sink.initialize(
        shopID,
        apiDomain,
      );

  @override
  void track(String trackEvent, String itemID) => _sink.track(
        trackEvent,
        itemID,
      );

  @override
  void recommend(
      String recommenderCode, bool extended, String itemID, String categoryID) {
    _sink.recommend(recommenderCode, extended, itemID, categoryID);
  }
}
