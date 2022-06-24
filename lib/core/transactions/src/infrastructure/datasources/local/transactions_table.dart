import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart' as j;

import 'transactions_db.dart';

part 'transactions_table.g.dart';

@j.JsonSerializable()
class BudgetManagement {
  final Map<String, double>? budgetToAmount;

  BudgetManagement({
    required this.budgetToAmount,
  });

  factory BudgetManagement.fromJson(Map<String, dynamic> json) =>
      _$BudgetManagementFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetManagementToJson(this);
}

enum TransactionTypeTable { expense, income }

enum IncomeTypeTable { active, pasive }

class BudgetManagementConverter
    extends TypeConverter<BudgetManagement, String> {
  const BudgetManagementConverter();
  @override
  BudgetManagement? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return BudgetManagement.fromJson(
      json.decode(fromDb) as Map<String, dynamic>,
    );
  }

  @override
  String? mapToSql(BudgetManagement? value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

@DataClassName('TransactionDbDto')
class TransactionsTable extends Table {
  TextColumn get id => text().customConstraint('UNIQUE')();
  IntColumn get transactionType => intEnum<TransactionTypeTable>()();
  TextColumn get title => text().withDefault(const Constant(''))();
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().withDefault(const Constant(''))();
  IntColumn get icon => integer()();
  IntColumn get color => integer()();
  TextColumn get userId => text().nullable()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get subCategoryId => text().nullable()();
  TextColumn get accountId => text().nullable()();
  TextColumn get budgetId => text().nullable()();
  IntColumn get incomeType => intEnum<IncomeTypeTable>().nullable()();
  BoolColumn get isIncomeManaged =>
      boolean().withDefault(const Constant(false))();
  TextColumn get budgetManagement =>
      text().map(const BudgetManagementConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'transactions';
}

@DataClassName('ScheduledTransactionDbDto')
class ScheduledTransactionsTable extends Table {
  TextColumn get id => text().customConstraint('UNIQUE')();
  IntColumn get transactionType => intEnum<TransactionTypeTable>()();
  TextColumn get title => text().withDefault(const Constant(''))();
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().withDefault(const Constant(''))();
  IntColumn get icon => integer()();
  IntColumn get color => integer()();
  TextColumn get userId => text().nullable()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get subCategoryId => text().nullable()();
  TextColumn get accountId => text().nullable()();
  TextColumn get budgetId => text().nullable()();
  IntColumn get incomeType => intEnum<IncomeTypeTable>().nullable()();
  BoolColumn get isIncomeManaged =>
      boolean().withDefault(const Constant(false))();
  TextColumn get budgetManagement =>
      text().map(const BudgetManagementConverter()).nullable()();
  DateTimeColumn get dueDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'scheduledTransactions';
}

@lazySingleton
@DriftAccessor(tables: [TransactionsTable])
class TransactionDao extends DatabaseAccessor<TransactionsDatabase>
    with _$TransactionDaoMixin {
  TransactionDao(TransactionsDatabase db) : super(db);

  Stream<List<TransactionDbDto>> getTransactions(String? userId) {
    final query = select(transactionsTable)
      ..where((tbl) => tbl.userId.equals(userId));
    return query.watch();
  }

  Future<void> createOrUpdate(Insertable<TransactionDbDto> transaction) =>
      into(transactionsTable).insertOnConflictUpdate(transaction);

  Future<void> deleteTransaction(String transactionId) =>
      (delete(transactionsTable)..where((tbl) => tbl.id.equals(transactionId)))
          .go();

  Future<void> deleteAllTransactions() => delete(transactionsTable).go();
}

@lazySingleton
@DriftAccessor(tables: [ScheduledTransactionsTable])
class ScheduledTransactionDao extends DatabaseAccessor<TransactionsDatabase>
    with _$ScheduledTransactionDaoMixin {
  ScheduledTransactionDao(TransactionsDatabase db) : super(db);

  Stream<List<ScheduledTransactionDbDto>> getTransactions(String? userId) {
    final query = select(scheduledTransactionsTable)
      ..where((tbl) => tbl.userId.equals(userId));
    return query.watch();
  }

  Future<void> createOrUpdate(
          Insertable<ScheduledTransactionDbDto> scheduledTransaction) =>
      into(scheduledTransactionsTable)
          .insertOnConflictUpdate(scheduledTransaction);

  Future<void> deleteTransaction(String transactionId) =>
      (delete(scheduledTransactionsTable)
            ..where((tbl) => tbl.id.equals(transactionId)))
          .go();

  Future<void> deleteAllTransactions() =>
      delete(scheduledTransactionsTable).go();
}
