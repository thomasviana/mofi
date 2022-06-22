import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/accounts/domain.dart';
import 'package:mofi/core/accounts/infrastructure.dart';

@lazySingleton
class AccountsFirebaseProvider {
  final FirebaseFirestore _firebaseFirestore;

  AccountsFirebaseProvider(
    this._firebaseFirestore,
  );

  User? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception.');
    return user;
  }

  CollectionReference<Map<String, dynamic>> collectionReference() =>
      _firebaseFirestore.collection('users/${currentUser!.uid}/accounts');

  // ACCOUNTS

  Future<void> addOrUpdateAccount(Account account) async {
    final accountDTO = AccountDto.fromDomain(account);
    final accountSnapshot = await collectionReference()
        .where('id', isEqualTo: account.id.value)
        .get();

    if (accountSnapshot.docs.isNotEmpty) {
      collectionReference()
          .doc(accountSnapshot.docs[0].reference.id)
          .update(accountDTO.toFirebaseMap());
    } else {
      collectionReference().add(accountDTO.toFirebaseMap());
    }
  }

  Stream<Option<List<Account>>> getAccounts() async* {
    yield* collectionReference()
        .orderBy('id', descending: false)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final accountsData = snapshot.docs
            .map((snapshot) => AccountDto.fromFirebaseMap(snapshot.data()))
            .toList();
        final accounts = accountsData.map((dto) => dto.toDomain()).toList();
        return some(accounts);
      } else {
        return none();
      }
    });
  }

  Future<void> deleteAccount(AccountId accountId) async {
    final accountSnapshot = await collectionReference()
        .where('id', isEqualTo: accountId.value)
        .get();

    if (accountSnapshot.docs.isEmpty) return;
    final accountReferenceId = accountSnapshot.docs[0].reference.id;
    collectionReference().doc(accountReferenceId).delete();
  }

  Future<void> deleteAllAccounts() async {
    final snapshots = await collectionReference().get();
    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
