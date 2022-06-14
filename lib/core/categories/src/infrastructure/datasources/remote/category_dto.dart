import 'package:mofi/core/categories/domain.dart';

class CategoryDto {
  final String id;
  final String name;
  final int icon;
  final int color;
  final int type;
  final String categoryUserId;
  CategoryDto({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
    required this.categoryUserId,
  });

  factory CategoryDto.fromDomain(Category category) {
    final categoryType = CategoryType.values[category.type.index];
    return CategoryDto(
      id: category.id.value,
      name: category.name,
      icon: category.icon,
      color: category.color,
      type: categoryType.index,
      categoryUserId: category.categoryUserId!.value,
    );
  }

  Category toDomain() {
    final userId = CategoryUserId(categoryUserId);
    final categoryType = CategoryType.values[type];

    return Category(
      id: CategoryId(id),
      categoryUserId: userId,
      name: name,
      icon: icon,
      color: color,
      type: categoryType,
    );
  }

  factory CategoryDto.fromFirebaseMap(Map<String?, Object?> data) {
    return CategoryDto(
      id: data['id']! as String,
      name: data['name']! as String,
      icon: data['icon']! as int,
      color: data['color']! as int,
      type: data['type']! as int,
      categoryUserId: data['categoryUserId']! as String,
    );
  }

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
      'type': type,
      'categoryUserId': categoryUserId,
    };
  }
}
