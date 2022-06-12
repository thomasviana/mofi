import 'package:mofi/core/categories/domain.dart';

class SubCategoryDto {
  final String id;
  final String name;
  final int icon;
  final int color;
  final double balance;
  final String categoryId;
  SubCategoryDto({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.balance,
    required this.categoryId,
  });

  factory SubCategoryDto.fromDomain(SubCategory subCategory) {
    return SubCategoryDto(
      id: subCategory.id.value,
      name: subCategory.name,
      icon: subCategory.icon,
      color: subCategory.icon,
      balance: subCategory.balance,
      categoryId: subCategory.categoryId.value,
    );
  }

  SubCategory toDomain() {
    return SubCategory(
      id: CategoryId(id),
      name: name,
      icon: icon,
      color: color,
      balance: balance,
      categoryId: CategoryId(categoryId),
    );
  }

  factory SubCategoryDto.fromFirebaseMap(Map<String?, Object?> data) {
    return SubCategoryDto(
      id: data['id']! as String,
      name: data['name']! as String,
      icon: data['icon']! as int,
      color: data['color']! as int,
      balance: data['balance']! as double,
      categoryId: data['categoryId']! as String,
    );
  }

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
      'balance': balance,
      'categoryId': categoryId,
    };
  }
}
