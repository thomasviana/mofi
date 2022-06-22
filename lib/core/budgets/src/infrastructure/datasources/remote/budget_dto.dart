import 'package:mofi/core/budgets/domain.dart';

class BudgetDto {
  final String id;
  final String name;
  final String? abbreviation;
  final int color;
  final String budgetUserId;
  BudgetDto({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.color,
    required this.budgetUserId,
  });

  factory BudgetDto.fromDomain(Budget budget) {
    return BudgetDto(
      id: budget.id.value,
      name: budget.name,
      abbreviation: budget.abbreviation,
      color: budget.color,
      budgetUserId: budget.budgetUserId!.value,
    );
  }

  Budget toDomain() {
    final userId = BudgetUserId(budgetUserId);

    return Budget(
      id: BudgetId(id),
      budgetUserId: userId,
      name: name,
      abbreviation: abbreviation,
      color: color,
    );
  }

  factory BudgetDto.fromFirebaseMap(Map<String?, Object?> data) {
    return BudgetDto(
      id: data['id']! as String,
      name: data['name']! as String,
      abbreviation: data['abbreviation'] as String?,
      color: data['color']! as int,
      budgetUserId: data['budgetUserId']! as String,
    );
  }

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'abbreviation': abbreviation,
      'color': color,
      'budgetUserId': budgetUserId,
    };
  }
}
