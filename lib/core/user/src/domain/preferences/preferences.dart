import 'package:mofi/common/value_objects.dart';

class Preferences implements ValueObject {
  final bool firsTimeOpen;

  const Preferences({
    required this.firsTimeOpen,
  });

  const Preferences.dflt() : firsTimeOpen = true;

  Preferences copyWith({
    bool? firsTimeOpen,
  }) {
    return Preferences(
      firsTimeOpen: firsTimeOpen ?? this.firsTimeOpen,
    );
  }
}
