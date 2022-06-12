import 'package:dartz/dartz.dart';

import '../../domain.dart';

abstract class SubCategoryRepository {
  Stream<List<SubCategory>> fetchSubCategories(
    CategoryId categoryId,
  );

  Stream<Option<List<SubCategory>>> fetchAllSubCategories();

  Future<void> save(SubCategory subCategory);

  Future<void> saveList(List<SubCategory> subCategories);

  Future<void> delete(CategoryId subCategoryId);

  Future<void> deleteAll();
}
