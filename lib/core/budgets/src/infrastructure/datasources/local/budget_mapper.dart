import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

@lazySingleton
class BudgetMapper {
  const BudgetMapper();

  Budget fromDbDto(BudgetDbDto dto) {
    final id = BudgetId(dto.id);
    final userId = BudgetUserId(dto.userId!);

    return Budget(
      id: id,
      name: dto.name,
      abbreviation: dto.abbreviation,
      color: dto.color,
      budgetUserId: userId,
    );
  }

  List<Budget> fromDbDtoList(List<BudgetDbDto> dtos) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  BudgetsTableCompanion toDbDto(Budget budget) {
    return BudgetsTableCompanion(
      id: Value(budget.id.value),
      name: Value(budget.name),
      abbreviation: Value(budget.abbreviation),
      color: Value(budget.color),
      userId: Value(budget.budgetUserId!.value),
    );
  }

  List<BudgetsTableCompanion> toDbDtoList(List<Budget> budgets) {
    return budgets.map((budget) => toDbDto(budget)).toList();
  }
}
