import 'dart:async';

import 'package:dartz/dartz.dart';
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

  Stream<Option<List<Category>>> call({required bool isFirstTimeOpen}) async* {
    yield* _getProfileInfo().switchMap((user) {
      return user.fold(
        () => Stream.value(None()),
        (user) => _categoryRepository.fetchCategories(
          CategoryUserId(user.id.value),
          isFirstTimeOpen: isFirstTimeOpen,
        ),
      );
    });
  }
}
