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

  Future<void> saveSubCategory(SubCategory subCategory);
  Future<void> saveSubCategories(List<SubCategory> subCategories);
  Stream<Option<List<SubCategory>>> getAllSubCategories();
  Stream<Option<List<SubCategory>>> getSubCategoriesByCategory(
    CategoryId categoryId,
  );
  Future<void> deleteSubCategory(SubCategory subCategory);
  Future<void> deleteAllSubCategories();
}

@LazySingleton(as: CategoriesRemoteDataSource)
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final CategoriesFirebaseProvider _categoryFirebaseProvider;

  CategoriesRemoteDataSourceImpl(
    this._categoryFirebaseProvider,
  );

  @override
  Future<void> addOrUpdateCategory(Category category) async {
    _categoryFirebaseProvider.addOrUpdateCategory(category);
  }

  @override
  Future<void> addOrUpdateCategories(List<Category> categories) async {
    for (final category in categories) {
      await _categoryFirebaseProvider.addOrUpdateCategory(category);
    }
  }

  @override
  Stream<Option<List<Category>>> getAllCategories() =>
      _categoryFirebaseProvider.getCategories();

  @override
  Future<void> deleteCategory(CategoryId categoryId) async {
    _categoryFirebaseProvider.deleteCategory(categoryId);
  }

  @override
  Future<void> deleteAllCategories() async {
    _categoryFirebaseProvider.deleteAllCategories();
  }

  @override
  Future<void> saveSubCategory(SubCategory subCategory) async {
    _categoryFirebaseProvider.saveSubCategory(subCategory);
  }

  @override
  Future<void> saveSubCategories(List<SubCategory> subCategories) async {
    for (final subCategory in subCategories) {
      await _categoryFirebaseProvider.saveSubCategory(subCategory);
    }
  }

  @override
  Stream<Option<List<SubCategory>>> getAllSubCategories() =>
      _categoryFirebaseProvider.getAllSubCategories();

  @override
  Stream<Option<List<SubCategory>>> getSubCategoriesByCategory(
    CategoryId categoryId,
  ) =>
      _categoryFirebaseProvider.getSubCategoriesByCategory(categoryId);

  @override
  Future<void> deleteSubCategory(SubCategory subCategory) async {
    _categoryFirebaseProvider.deleteSubCategory(subCategory);
  }

  @override
  Future<void> deleteAllSubCategories() async {
    _categoryFirebaseProvider.deleteAllSubCategories();
  }
}
