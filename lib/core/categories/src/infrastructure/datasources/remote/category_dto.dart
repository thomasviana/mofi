import 'package:mofi/core/categories/domain.dart';

class CategoryDto {
  final String id;
  final String name;
  final int icon;
  final int color;
  final double balance;
  final int type;
  final String categoryUserId;
  CategoryDto({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.balance,
    required this.type,
    required this.categoryUserId,
  });

  factory CategoryDto.fromDomain(Category category) {
    final categoryType = CategoryType.values[category.type.index];
    return CategoryDto(
      id: category.id.value,
      name: category.name,
      icon: category.icon,
      color: category.icon,
      balance: category.balance,
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
      balance: balance,
      type: categoryType,
    );
  }

  factory CategoryDto.fromFirebaseMap(Map<String?, Object?> data) {
    return CategoryDto(
      id: data['id']! as String,
      name: data['name']! as String,
      icon: data['icon']! as int,
      color: data['color']! as int,
      balance: data['balance']! as double,
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
      'balance': balance,
      'type': type,
      'categoryUserId': categoryUserId,
    };
  }
}
