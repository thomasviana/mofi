import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class ResetTransactions {
  final TransactionRepository _transactionRepository;

  const ResetTransactions(
    this._transactionRepository,
  );

  Future<void> call() async {
    _transactionRepository.deleteAll();
  }
}
