import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/transactions/domain.dart';
import 'package:mofi/core/transactions/infrastructure.dart';

@lazySingleton
class TransactionsFirebaseProvider {
  final FirebaseFirestore _firebaseFirestore;

  TransactionsFirebaseProvider(
    this._firebaseFirestore,
  );

  User? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception.');
    return user;
  }

  // TRANSACTIONS

  Future<void> addOrUpdateTransaction(Transaction transaction) async {
    final ref =
        _firebaseFirestore.collection('users/${currentUser!.uid}/transactions');

    final transactionDTO = TransactionDto.fromDomain(transaction);
    final transactionSnapshot =
        await ref.where('id', isEqualTo: transaction.id.value).get();

    if (transactionSnapshot.docs.isNotEmpty) {
      await ref
          .doc(transactionSnapshot.docs[0].reference.id)
          .update(transactionDTO.toFirebaseMap());
    } else {
      await ref.add(transactionDTO.toFirebaseMap());
    }
  }

  Stream<Option<List<Transaction>>> getTransactions() async* {
    yield* _firebaseFirestore
        .collection('users/${currentUser!.uid}/transactions')
        .orderBy('id', descending: false)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final transactionsData = snapshot.docs
            .map((snapshot) => TransactionDto.fromFirebaseMap(snapshot.data()))
            .toList();
        final transactions =
            transactionsData.map((dto) => dto.toDomain()).toList();
        return some(transactions);
      } else {
        return none();
      }
    });
  }

  // Future<void> deleteTransaction(TransactionId transactionId) async {
  //   final ref = _firebaseFirestore
  //       .collection('users/${currentUser!.uid}/transactions')
  //       .doc(transactionId.value);
  //   await ref.delete();
  // }

  Future<void> deleteTransaction(TransactionId transactionId) async {
    final transactionSnapshot = await _firebaseFirestore
        .collection('users/${currentUser!.uid}/transactions')
        .where('id', isEqualTo: transactionId.value)
        .get();

    if (transactionSnapshot.docs.isEmpty) return;
    final transactionReferenceId = transactionSnapshot.docs[0].reference.id;
    final ref = _firebaseFirestore
        .collection(
          'users/${currentUser!.uid}/transactions/',
        )
        .doc(transactionReferenceId);
    await ref.delete();
  }

  Future<void> deleteAllTransactions() async {
    final snapshots = await _firebaseFirestore
        .collection('users/${currentUser!.uid}/transactions')
        .get();
    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
