import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  PreferenceService._();

  factory PreferenceService.getInstance() => _instance;

  static final PreferenceService _instance = PreferenceService._();

  static const String uid = 'uid';
  static const String language = 'english';

  Future<SharedPreferences> _getInstance() async {
    return SharedPreferences.getInstance();
  }

  Future<void> setUID(String uid) async {
    (await _getInstance()).setString(PreferenceService.uid, uid);
  }

  Future<void> setLanguage(String language) async {
    (await _getInstance()).setString(PreferenceService.language, language);
  }
    
    Future<String?> getLanguage() async {
    return (await _getInstance()).getString(PreferenceService.language);
  }

  Future<String?> getUID() async {
    return (await _getInstance()).getString(PreferenceService.uid);
  }
  
  Future<void> removeUID() async {
    (await _getInstance()).setString(PreferenceService.uid, "");
  }
}