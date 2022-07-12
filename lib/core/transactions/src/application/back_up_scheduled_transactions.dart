import 'package:injectable/injectable.dart';
import 'package:mofi/core/user/application.dart';

import '../../domain.dart';

@injectable
class BackUpScheduledTransactions {
  final GetProfileInfo _getProfileInfo;
  final TransactionRepository _transactionRepository;

  const BackUpScheduledTransactions(
    this._getProfileInfo,
    this._transactionRepository,
  );

  Future<void> call() async {
    final user = await _getProfileInfo().first;
    user.fold(
      () {},
      (user) => _transactionRepository
          .backUpScheduled(TransactionUserId(user.id.value)),
    );
  }
}
