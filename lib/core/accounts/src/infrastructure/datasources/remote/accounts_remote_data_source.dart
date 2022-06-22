import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

abstract class AccountsRemoteDataSource {
  Future<void> addOrUpdateAccount(Account account);
  Future<void> addOrUpdateAccounts(List<Account> accounts);
  Stream<Option<List<Account>>> getAllAccounts();
  Future<void> deleteAccount(AccountId accountId);
  Future<void> deleteAllAccounts();
}

@LazySingleton(as: AccountsRemoteDataSource)
class AccountsRemoteDataSourceImpl implements AccountsRemoteDataSource {
  final AccountsFirebaseProvider _accountsFirebaseProvider;

  AccountsRemoteDataSourceImpl(
    this._accountsFirebaseProvider,
  );

  @override
  Future<void> addOrUpdateAccount(Account account) =>
      _accountsFirebaseProvider.addOrUpdateAccount(account);

  @override
  Future<void> addOrUpdateAccounts(List<Account> accounts) async {
    for (final account in accounts) {
      await _accountsFirebaseProvider.addOrUpdateAccount(account);
    }
  }

  @override
  Stream<Option<List<Account>>> getAllAccounts() =>
      _accountsFirebaseProvider.getAccounts();

  @override
  Future<void> deleteAccount(AccountId accountId) =>
      _accountsFirebaseProvider.deleteAccount(accountId);

  @override
  Future<void> deleteAllAccounts() =>
      _accountsFirebaseProvider.deleteAllAccounts();
}
