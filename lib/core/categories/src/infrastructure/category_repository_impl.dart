import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoriesLocalDataSource _localDataSource;
  final CategoriesRemoteDataSource _remoteDataSource;

  CategoryRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  bool _isFirstTimeOpen = true;

  @override
  Stream<List<Category>> fetchCategories(
    CategoryUserId userId, {
    required bool isFirstTimeOpen,
  }) async* {
    _isFirstTimeOpen = isFirstTimeOpen;
    if (_isFirstTimeOpen) {
      _remoteDataSource.getAllCategories().asyncMap(
            (optionRemoteCategories) => optionRemoteCategories.fold(
              () async {
                final defaultCategories = Category.defaultCategories;
                for (final category in defaultCategories) {
                  category.setUserId(userId.value);
                }
                await saveList(defaultCategories);
                _isFirstTimeOpen = false;
              },
              (remoteCategories) async {
                for (final category in remoteCategories) {
                  category.setUserId(userId.value);
                }
                _localDataSource.cacheCategories(remoteCategories);
                _isFirstTimeOpen = false;
              },
            ),
          );
    }
    yield* _localDataSource.getCachedCategories(userId).asyncMap(
          (optionCachedCategories) => optionCachedCategories.fold(
            () {
              return Future.value([]);
            },
            (cachedCategories) async {
              await _remoteDataSource.addOrUpdateCategories(
                cachedCategories,
              ); //TODO: Ensure createOrUpdate or Weekly Backup function.
              return Future.value(cachedCategories);
            },
          ),
        );
  }

  @override
  Future<void> save(Category category) async {
    await _localDataSource.cacheCategory(category);
    await _remoteDataSource.saveCategory(category);
  }

  @override
  Future<void> saveList(List<Category> categories) async {
    await _localDataSource.cacheCategories(categories);
    await _remoteDataSource.addOrUpdateCategories(categories);
  }

  @override
  Future<void> delete(CategoryId categoryId) async {
    await _localDataSource.deleteCategory(categoryId);
    await _remoteDataSource.deleteCategory(categoryId);
  }

  @override
  Future<void> deleteAll() async {
    await _localDataSource.deleteAllCategories();
    await _remoteDataSource.deleteAllCategories();
  }
}
