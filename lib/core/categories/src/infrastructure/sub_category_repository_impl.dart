import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: SubCategoryRepository)
class SubCategoryRepositoryImpl implements SubCategoryRepository {
  final CategoriesLocalDataSource _localDataSource;
  final CategoriesRemoteDataSource _remoteDataSource;

  SubCategoryRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  @override
  Stream<List<SubCategory>> fetchSubCategories(
    CategoryId categoryId,
  ) async* {
    yield* _localDataSource.getCachedSubCategories(categoryId).switchMap(
          (optionCachedSubCategories) => optionCachedSubCategories.fold(
            () => _remoteDataSource.getAllSubCategories().switchMap(
                  (optionRemoteSubCategories) => optionRemoteSubCategories.fold(
                    () => Stream.value([]),
                    (remoteSubCategories) {
                      saveList(remoteSubCategories);
                      return Stream.value(remoteSubCategories);
                    },
                  ),
                ),
            (cachedSubCategories) => Stream.value(cachedSubCategories),
          ),
        );
  }

  @override
  Stream<Option<List<SubCategory>>> fetchAllSubCategories() {
    return _localDataSource.getAllCachedSubCategories();
  }

  @override
  Future<void> save(SubCategory subCategory) async {
    await _localDataSource.cacheSubCategory(subCategory);
    await _remoteDataSource.saveSubCategory(subCategory);
  }

  @override
  Future<void> saveList(List<SubCategory> subCategories) async {
    await _localDataSource.cacheSubCategories(subCategories);
    await _remoteDataSource.saveSubCategories(subCategories);
  }

  @override
  Future<void> delete(CategoryId subCategoryId) {
    return _localDataSource.deleteSubCategory(subCategoryId);
  }

  @override
  Future<void> deleteAll() {
    return _localDataSource.deleteAllSubCategories();
  }
}
