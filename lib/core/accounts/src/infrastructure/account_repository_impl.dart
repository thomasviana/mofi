import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl implements AccountRepository {
  final AccountsLocalDataSource _accountsLocalDataSource;
  final AccountsRemoteDataSource _accountsRemoteDataSource;

  AccountRepositoryImpl(
    this._accountsLocalDataSource,
    this._accountsRemoteDataSource,
  );

  bool _isFirstTimeOpen = true;

  @override
  Stream<Option<List<Account>>> fetchAccounts(
    AccountUserId userId, {
    required bool isFirstTimeOpen,
  }) async* {
    if (_isFirstTimeOpen) _getRemoteAccountsOrSetDefault(userId);
    yield* _accountsLocalDataSource.getCachedAccounts(userId).asyncMap(
          (optionCachedAccounts) => optionCachedAccounts.fold(
            () => Future.value(None()),
            (cachedAccounts) => Future.value(some(cachedAccounts)),
          ),
        );
  }

  Future<void> _getRemoteAccountsOrSetDefault(AccountUserId userId) =>
      _accountsRemoteDataSource.getAllAccounts().first.then(
            (optionRemoteAccounts) => optionRemoteAccounts.fold(
              () async {
                final defaultAccounts = Account.defaultAccounts;
                for (final account in defaultAccounts) {
                  account.setUserId(userId.value);
                }
                await saveList(defaultAccounts);
                _isFirstTimeOpen = false;
              },
              (remoteAccounts) async {
                await _accountsLocalDataSource.cacheAccounts(remoteAccounts);
                _isFirstTimeOpen = false;
              },
            ),
          );

  @override
  Future<void> save(Account account) async {
    await _accountsLocalDataSource.cacheAccount(account);
    await _accountsRemoteDataSource.addOrUpdateAccount(account);
  }

  @override
  Future<void> saveList(List<Account> accounts) async {
    await _accountsLocalDataSource.cacheAccounts(accounts);
  }

  @override
  Future<void> delete(AccountId accountId) async {
    await _accountsLocalDataSource.deleteAccount(accountId);
    await _accountsRemoteDataSource.deleteAccount(accountId);
  }

  @override
  Future<void> deleteAll() async {
    await _accountsLocalDataSource.deleteAllAccounts();
    await _accountsRemoteDataSource.deleteAllAccounts();
  }

  @override
  Future<void> backUp(AccountUserId userId) async {
    _accountsLocalDataSource.getCachedAccounts(userId).first.then(
          (optionLocalAccounts) => optionLocalAccounts.fold(
            () {},
            (accounts) =>
                _accountsRemoteDataSource.addOrUpdateAccounts(accounts),
          ),
        );
  }
}
