import 'rees46_plugin.g.dart';

abstract class IRees46Controller {
  Future<void> initialize(String shopID, String? apiDomain);

  Future<void> track(
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

  Future<void> setProfile(
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
  Future<void> initialize(String shopID, String? apiDomain) async {
    try {
      await _sink.initialize(shopID, apiDomain);
    } catch (e) {
      print('Ошибка инициализации REES46: $e');
      rethrow;
    }
  }

  @override
  Future<void> track(
    String trackEvent,
    String itemID, {
    int? amount,
  }) async {
    try {
      await _sink.track(trackEvent, itemID, amount: amount);
    } catch (e) {
      print('Ошибка отслеживания события: $e');
      rethrow;
    }
  }

  @override
  Future<List<String>?> recommend(String recommenderCode, bool extended,
      String itemID, String categoryID) async {
    try {
      final result = await _sink.recommend(
          recommenderCode, extended, itemID, categoryID);
      // Фильтруем null значения и преобразуем в List<String>
      return result?.where((element) => element != null).cast<String>().toList();
    } catch (e) {
      print('Ошибка получения рекомендаций: $e');
      rethrow;
    }
  }

  @override
  Future<void> setProfile(
    String userId,
    String email,
    String phone,
  ) async {
    try {
      await _sink.setProfile(userId, email, phone);
    } catch (e) {
      print('Ошибка установки профиля: $e');
      rethrow;
    }
  }
}