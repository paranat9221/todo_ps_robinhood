import 'package:todo_ps_robinhood/services/local/local_storage.dart';

abstract class PinRepository {
  Future<DateTime?> fetchLatestPinTime();
  void updateLatestPinTime({required DateTime dateTime});
  void clearLatestPinTime();
}

class PinRepositoryIml extends PinRepository {
  @override
  Future<DateTime?> fetchLatestPinTime() async {
    try {
      DateTime? latestPinTime = await LocalStorageService().getLatestPinTime();
      return latestPinTime;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void updateLatestPinTime({required DateTime dateTime}) {
    try {
      LocalStorageService().setLatestPinTime(dateTime: dateTime);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void clearLatestPinTime() {
    try {
      LocalStorageService().clearLatestPinTime();
    } catch (e) {
      rethrow;
    }
  }
}
