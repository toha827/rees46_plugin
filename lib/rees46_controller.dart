import 'rees46_plugin.g.dart';

abstract class IRees46Controller {
  void initialize(String shopID, String? apiDomain, String? token);

  void track(
    String trackEvent,
    String itemID, {
    int? amount,
  });

  Future<List<String>?> recommend(
    String recommenderCode,
    bool extended,
    String itemID,
    String categoryID,
  );

  void setProfile(
    String userId,
    String email,
    String phone,
  );
}

class Rees46Controller implements IRees46Controller, Rees46Receiver {
  static Rees46Controller? _instance;

  factory Rees46Controller.instance() => _instance ?? Rees46Controller._();

  Rees46Controller._() : _sink = Rees46Sender() {
    Rees46Receiver.setUp(this);
  }

  final Rees46Sender _sink;

  @override
  void initialize(String shopID, String? apiDomain, String? token) =>
      _sink.initialize(
        shopID,
        apiDomain,
        token,
      );

  @override
  void track(
    String trackEvent,
    String itemID, {
    int? amount,
  }) =>
      _sink.track(
        trackEvent,
        itemID,
        amount: amount,
      );

  @override
  Future<List<String>?> recommend(String recommenderCode, bool extended,
      String itemID, String categoryID) async {
    return (await _sink.recommend(
            recommenderCode, extended, itemID, categoryID))
        ?.where((element) => element != null)
        .map((e) => e!)
        .toList();
  }

  @override
  void setProfile(
    String userId,
    String email,
    String phone,
  ) {
    _sink.setProfile(
      userId,
      email,
      phone,
    );
  }
}
