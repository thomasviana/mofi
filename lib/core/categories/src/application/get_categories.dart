import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class GetCategories {
  final CategoryRepository _categoryRepository;
  final GetProfileInfo _getProfileInfo;

  const GetCategories(
    this._categoryRepository,
    this._getProfileInfo,
  );

  Stream<List<Category>> call({required bool isFirstTimeOpen}) async* {
    yield* _getProfileInfo().switchMap((user) {
      if (user != null) {
        return _categoryRepository.fetchCategories(
          CategoryUserId(user.id.value),
          isFirstTimeOpen: isFirstTimeOpen,
        );
      } else {
        return Stream.value([]);
      }
    });
  }
}
