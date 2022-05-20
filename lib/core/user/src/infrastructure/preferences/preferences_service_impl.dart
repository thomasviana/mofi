import 'package:injectable/injectable.dart';
import 'package:mofi/core/user/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: PreferencesService)
class ImplPreferencesService implements PreferencesService {
  final SharedPreferences _preferences;

  const ImplPreferencesService(this._preferences);

  static const _keyFirstTimeOpen = 'first_time_open';

  @override
  Future<void> changeFirstTimeOpenToFalse() async {
    await _preferences.setBool(_keyFirstTimeOpen, false);
  }

  @override
  Stream<bool> get firstTimeOpen => Stream.value(
        _preferences.getBool(_keyFirstTimeOpen) ??
            Preferences.dflt().firsTimeOpen,
      );
}
