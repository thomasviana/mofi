import 'dart:async';

import 'package:dartz/dartz.dart';
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
  Stream<Option<List<Category>>> fetchCategories(
    CategoryUserId userId, {
    required bool isFirstTimeOpen,
  }) async* {
    _isFirstTimeOpen = isFirstTimeOpen;
    if (_isFirstTimeOpen) _getRemoteCategoriesOrSetDefault(userId);
    yield* _localDataSource.getCachedCategories(userId).asyncMap(
          (optionCachedCategories) => optionCachedCategories.fold(
            () => Future.value(None()),
            (cachedCategories) => Future.value(some(cachedCategories)),
          ),
        );
  }

  Future<void> _getRemoteCategoriesOrSetDefault(CategoryUserId userId) =>
      _remoteDataSource.getAllCategories().first.then(
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
                await _localDataSource.cacheCategories(remoteCategories);
                _isFirstTimeOpen = false;

                _getRemoteSubCategoriesOrSetDefault();
              },
            ),
          );

  Future<void> _getRemoteSubCategoriesOrSetDefault() =>
      _remoteDataSource.getAllSubCategories().first.then(
            (optionRemoteSubCategories) => optionRemoteSubCategories.fold(
              () {
                final defaultSubCategories = SubCategory.allSubCategories;
                _localDataSource.cacheSubCategories(defaultSubCategories);
              },
              (remoteSubCategories) {
                _localDataSource.cacheSubCategories(remoteSubCategories);
              },
            ),
          );

  @override
  Future<void> save(Category category) async {
    await _localDataSource.cacheCategory(category);
    await _remoteDataSource.addOrUpdateCategory(category);
  }

  @override
  Future<void> saveList(List<Category> categories) async {
    await _localDataSource.cacheCategories(categories);
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

  @override
  Future<void> backUp(CategoryUserId userId) async {
    _localDataSource.getAllCachedSubCategories().first.then(
          (optionSubCategories) => optionSubCategories.fold(
            () async {
              final defaultSubCategories = SubCategory.allSubCategories;
              await _localDataSource.cacheSubCategories(defaultSubCategories);
              _backUpAllCategoriesAndSubCategories(userId);
            },
            (_) => _backUpAllCategoriesAndSubCategories(userId),
          ),
        );
  }

  Future<void> _backUpAllCategoriesAndSubCategories(CategoryUserId userId) =>
      _localDataSource.getCachedCategories(userId).first.then(
            (optionLocalCategories) => optionLocalCategories.fold(
              () {},
              (categories) async {
                await _remoteDataSource.addOrUpdateCategories(categories);
                for (final category in categories) {
                  _localDataSource
                      .getCachedSubCategories(category.id)
                      .first
                      .then(
                        (optionSubCategories) => {
                          optionSubCategories.fold(
                            () {},
                            (subCategories) => _remoteDataSource
                                .addOrUpdateSubCategories(subCategories),
                          )
                        },
                      );
                }
              },
            ),
          );
}
