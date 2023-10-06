import 'package:shared_preferences/shared_preferences.dart';

enum StorageKey { latestPinTime }

class LocalStorageService {
  Future<DateTime?> getLatestPinTime() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    final int? timestamp =
        sharedPrefs.getInt(StorageKey.latestPinTime.toString());

    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }

  Future<void> setLatestPinTime({required DateTime dateTime}) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    int timestamp = dateTime.millisecondsSinceEpoch;

    sharedPrefs.setInt(StorageKey.latestPinTime.toString(), timestamp);
  }

  Future<void> clearLatestPinTime() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    sharedPrefs.remove(StorageKey.latestPinTime.toString());
  }
}
