import 'package:mofi/core/accounts/domain.dart';

class AccountDto {
  final String id;
  final String name;
  final int color;
  final int type;
  final String accountUserId;
  AccountDto({
    required this.id,
    required this.name,
    required this.color,
    required this.type,
    required this.accountUserId,
  });

  factory AccountDto.fromDomain(Account account) {
    final accountType = AccountType.values[account.type.index];
    return AccountDto(
      id: account.id.value,
      name: account.name,
      color: account.color,
      type: accountType.index,
      accountUserId: account.accountUserId!.value,
    );
  }

  Account toDomain() {
    final userId = AccountUserId(accountUserId);
    final accountType = AccountType.values[type];

    return Account(
      id: AccountId(id),
      accountUserId: userId,
      name: name,
      color: color,
      type: accountType,
    );
  }

  factory AccountDto.fromFirebaseMap(Map<String?, Object?> data) {
    return AccountDto(
      id: data['id']! as String,
      name: data['name']! as String,
      color: data['color']! as int,
      type: data['type']! as int,
      accountUserId: data['accountUserId']! as String,
    );
  }

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'color': color,
      'type': type,
      'accountUserId': accountUserId,
    };
  }
}
