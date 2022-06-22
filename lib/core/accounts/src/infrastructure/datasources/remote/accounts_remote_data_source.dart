import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

abstract class AccountsRemoteDataSource {
  Future<void> addOrUpdateAccount(Account category);
  Future<void> addOrUpdateAccounts(List<Account> accounts);
  Stream<Option<List<Account>>> getAllAccounts();
  Future<void> deleteAccount(AccountId categoryId);
  Future<void> deleteAllAccounts();
}

@LazySingleton(as: AccountsRemoteDataSource)
class AccountsRemoteDataSourceImpl implements AccountsRemoteDataSource {
  final AccountsFirebaseProvider _accountsFirebaseProvider;

  AccountsRemoteDataSourceImpl(
    this._accountsFirebaseProvider,
  );

  @override
  Future<void> addOrUpdateAccount(Account category) =>
      _accountsFirebaseProvider.addOrUpdateAccount(category);

  @override
  Future<void> addOrUpdateAccounts(List<Account> accounts) async {
    for (final category in accounts) {
      await _accountsFirebaseProvider.addOrUpdateAccount(category);
    }
  }

  @override
  Stream<Option<List<Account>>> getAllAccounts() =>
      _accountsFirebaseProvider.getAccounts();

  @override
  Future<void> deleteAccount(AccountId categoryId) =>
      _accountsFirebaseProvider.deleteAccount(categoryId);

  @override
  Future<void> deleteAllAccounts() =>
      _accountsFirebaseProvider.deleteAllAccounts();
}
