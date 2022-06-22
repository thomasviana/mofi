import 'package:injectable/injectable.dart';
import 'package:mofi/core/user/application.dart';

import '../../domain.dart';

@injectable
class BackUpTransactions {
  final GetProfileInfo _getProfileInfo;
  final TransactionRepository _transactionRepository;

  const BackUpTransactions(
    this._getProfileInfo,
    this._transactionRepository,
  );

  Future<void> call() async {
    final user = await _getProfileInfo().first;
    user.fold(
      () {},
      (user) => _transactionRepository.backUp(TransactionUserId(user.id.value)),
    );
  }
}
