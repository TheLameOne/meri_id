import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  PreferenceService._();

  factory PreferenceService.getInstance() => _instance;

  static final PreferenceService _instance = PreferenceService._();

  static const String uid = 'uid';

  Future<SharedPreferences> _getInstance() async {
    return SharedPreferences.getInstance();
  }

  Future<void> setUID(String uid) async {
    (await _getInstance()).setString(PreferenceService.uid, uid);
  }

  Future<String?> getUID() async {
    return (await _getInstance()).getString(PreferenceService.uid);
  }
  
  Future<void> removeUID() async {
    (await _getInstance()).setString(PreferenceService.uid, "");
  }
}