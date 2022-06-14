import 'package:injectable/injectable.dart';
import 'package:mofi/core/user/application.dart';

import '../../domain.dart';

@injectable
class BackUpCategories {
  final GetProfileInfo _getProfileInfo;
  final CategoryRepository _categoryRepository;

  const BackUpCategories(
    this._getProfileInfo,
    this._categoryRepository,
  );

  Future<void> call() async {
    final user = await _getProfileInfo().first;
    user.fold(
      () {},
      (user) => _categoryRepository.backUp(CategoryUserId(user.id.value)),
    );
  }
}
