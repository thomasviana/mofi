import 'package:dartz/dartz.dart';

import '../../domain.dart';

abstract class AccountRepository {
  Stream<Option<List<Account>>> fetchAccounts(
    AccountUserId userId, {
    required bool isFirstTimeOpen,
  });

  Future<void> save(Account account);

  Future<void> saveList(List<Account> accounts);

  Future<void> delete(AccountId accountId);

  Future<void> deleteAll();

  Future<void> backUp(AccountUserId userId);
}
