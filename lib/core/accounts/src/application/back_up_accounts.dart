import 'package:injectable/injectable.dart';
import 'package:mofi/core/user/application.dart';

import '../../domain.dart';

@injectable
class BackUpAccounts {
  final GetProfileInfo _getProfileInfo;
  final AccountRepository _accountRepository;

  const BackUpAccounts(
    this._getProfileInfo,
    this._accountRepository,
  );

  Future<void> call() async {
    final user = await _getProfileInfo().first;
    user.fold(
      () {},
      (user) => _accountRepository.backUp(AccountUserId(user.id.value)),
    );
  }
}
