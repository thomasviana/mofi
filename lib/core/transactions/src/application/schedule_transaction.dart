import 'package:cron/cron.dart';
import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class ScheduleTransaction {
  final TransactionRepository _transactionRepository;
  final GetProfileInfo _getProfileInfo;
  final Cron _cron;

  const ScheduleTransaction(
    this._transactionRepository,
    this._getProfileInfo,
    this._cron,
  );

  Future<void>? call({
    required Transaction transaction,
    required DateTime dueDate,
  }) async {
    final user = await _getProfileInfo().first;
    user.fold(
      () => null,
      (user) async {
        await _transactionRepository.saveScheduledTransaction(
          ScheduledTransaction(dueDate: dueDate, transaction: transaction),
        );
        _cron.schedule(
          Schedule.parse('/5 * * * * *'),
          () async => _transactionRepository.save(transaction),
        );
      },
    );
  }
}
