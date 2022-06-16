part of 'edit_category_screen_bloc.dart';

class EditCategoryScreenState {
  final Category? category;
  final List<SubCategory>? subCategories;
  final bool isLoading;
  final bool isEditMode;

  EditCategoryScreenState({
    this.category,
    this.subCategories,
    required this.isLoading,
    required this.isEditMode,
  });

  bool get isDefaultCategory => Category.defaultCategories
      .any((category) => category.id.value == this.category?.id.value);

  List<SubCategory> get subCategoriesWithoutGeneral => (subCategories ?? [])
      .where((subCategory) => subCategory.id != subCategory.categoryId)
      .toList();

  factory EditCategoryScreenState.initial() => EditCategoryScreenState(
        isLoading: true,
        isEditMode: true,
      );

  EditCategoryScreenState copyWith({
    Category? category,
    List<SubCategory>? subCategories,
    bool? isLoading,
    bool? isEditMode,
  }) {
    return EditCategoryScreenState(
      category: category ?? this.category,
      subCategories: subCategories ?? this.subCategories,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
