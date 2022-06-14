import '../../domain.dart';

abstract class CategoryRepository {
  Stream<List<Category>> fetchCategories(
    CategoryUserId userId, {
    required bool isFirstTimeOpen,
  });

  Future<void> save(Category category);

  Future<void> saveList(List<Category> categories);

  Future<void> delete(CategoryId categoryId);

  Future<void> deleteAll();

  Future<void> backUp(CategoryUserId userId);
}
