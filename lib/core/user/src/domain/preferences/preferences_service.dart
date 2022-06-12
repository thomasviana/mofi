abstract class PreferencesService {
  Stream<bool> get firstTimeOpen;

  Future<void> setFirstTimeOpenToFalse();
}
