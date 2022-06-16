import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

abstract class CategoriesRemoteDataSource {
  Future<void> addOrUpdateCategory(Category category);
  Future<void> addOrUpdateCategories(List<Category> categories);
  Stream<Option<List<Category>>> getAllCategories();
  Future<void> deleteCategory(CategoryId categoryId);
  Future<void> deleteAllCategories();

  Future<void> addOrUpdateSubCategory(SubCategory subCategory);
  Future<void> addOrUpdateSubCategories(List<SubCategory> subCategories);
  Stream<Option<List<SubCategory>>> getAllSubCategories();
  Stream<Option<List<SubCategory>>> getSubCategoriesByCategory(
    CategoryId categoryId,
  );
  Future<void> deleteSubCategory(SubCategory subCategory);
  Future<void> deleteAllSubCategories();
}

@LazySingleton(as: CategoriesRemoteDataSource)
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final CategoriesFirebaseProvider _categoriesFirebaseProvider;

  CategoriesRemoteDataSourceImpl(
    this._categoriesFirebaseProvider,
  );

  @override
  Future<void> addOrUpdateCategory(Category category) =>
      _categoriesFirebaseProvider.addOrUpdateCategory(category);

  @override
  Future<void> addOrUpdateCategories(List<Category> categories) async {
    for (final category in categories) {
      await _categoriesFirebaseProvider.addOrUpdateCategory(category);
    }
  }

  @override
  Stream<Option<List<Category>>> getAllCategories() =>
      _categoriesFirebaseProvider.getCategories();

  @override
  Future<void> deleteCategory(CategoryId categoryId) =>
      _categoriesFirebaseProvider.deleteCategory(categoryId);

  @override
  Future<void> deleteAllCategories() =>
      _categoriesFirebaseProvider.deleteAllCategories();

  @override
  Future<void> addOrUpdateSubCategory(SubCategory subCategory) =>
      _categoriesFirebaseProvider.addOrUpdateSubCategory(subCategory);

  @override
  Future<void> addOrUpdateSubCategories(List<SubCategory> subCategories) async {
    for (final subCategory in subCategories) {
      await _categoriesFirebaseProvider.addOrUpdateSubCategory(subCategory);
    }
  }

  @override
  Stream<Option<List<SubCategory>>> getAllSubCategories() =>
      _categoriesFirebaseProvider.getCategories().asyncMap(
            (optionCategories) => optionCategories.fold(
              () => none(),
              (categories) async {
                final allSubCategories = <SubCategory>[];
                for (final category in categories) {
                  final subCategories = await _categoriesFirebaseProvider
                      .getSubCategoriesByCategory(category.id)
                      .first;
                  allSubCategories.addAll(subCategories.getOrElse(() => []));
                }
                return some(allSubCategories);
              },
            ),
          );

  @override
  Stream<Option<List<SubCategory>>> getSubCategoriesByCategory(
    CategoryId categoryId,
  ) =>
      _categoriesFirebaseProvider.getSubCategoriesByCategory(categoryId);

  @override
  Future<void> deleteSubCategory(SubCategory subCategory) =>
      _categoriesFirebaseProvider.deleteSubCategory(subCategory);

  @override
  Future<void> deleteAllSubCategories() =>
      _categoriesFirebaseProvider.deleteAllSubCategories();
}
