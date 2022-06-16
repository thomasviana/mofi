import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

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
    yield* _localDataSource.getCachedSubCategories(categoryId).asyncMap(
          (optionCachedSubCategories) => optionCachedSubCategories.fold(
            () => Future.value([]),
            (cachedSubCategories) => Future.value(cachedSubCategories),
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
    await _remoteDataSource.addOrUpdateSubCategory(subCategory);
  }

  @override
  Future<void> saveList(List<SubCategory> subCategories) async {
    await _localDataSource.cacheSubCategories(subCategories);
  }

  @override
  Future<void> delete(SubCategory subCategory) async {
    await _localDataSource.deleteSubCategory(subCategory.id);
    await _remoteDataSource.deleteSubCategory(subCategory);
  }

  @override
  Future<void> deleteAll() async {
    await _localDataSource.deleteAllSubCategories();
    await _remoteDataSource.deleteAllSubCategories();
  }
}
