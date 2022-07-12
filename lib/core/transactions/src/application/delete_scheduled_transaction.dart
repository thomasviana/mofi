import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class DeleteScheduledTransaction {
  final TransactionRepository _transactionRepository;

  const DeleteScheduledTransaction(this._transactionRepository);

  Future<void> call(TransactionId transactionId) {
    return _transactionRepository.deleteScheduled(transactionId);
  }
}
