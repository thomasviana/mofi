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

  CollectionReference<Map<String, dynamic>> collectionReference() =>
      _firebaseFirestore.collection('users/${currentUser!.uid}/transactions');

  CollectionReference<Map<String, dynamic>> scheduledCollectionReference() =>
      _firebaseFirestore
          .collection('users/${currentUser!.uid}/scheduledTransactions');

  // Transactions

  Future<void> addOrUpdateTransaction(Transaction transaction) async {
    final transactionDTO = TransactionDto.fromDomain(transaction);
    final transactionSnapshot = await collectionReference()
        .where('id', isEqualTo: transaction.id.value)
        .get();

    if (transactionSnapshot.docs.isNotEmpty) {
      collectionReference()
          .doc(transactionSnapshot.docs[0].reference.id)
          .update(transactionDTO.toFirebaseMap());
    } else {
      collectionReference().add(transactionDTO.toFirebaseMap());
    }
  }

  Stream<Option<List<Transaction>>> getTransactions() async* {
    yield* collectionReference()
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

  Future<void> deleteTransaction(TransactionId transactionId) async {
    final transactionSnapshot = await collectionReference()
        .where('id', isEqualTo: transactionId.value)
        .get();

    if (transactionSnapshot.docs.isEmpty) return;
    final transactionReferenceId = transactionSnapshot.docs[0].reference.id;
    collectionReference().doc(transactionReferenceId).delete();
  }

  Future<void> deleteAllTransactions() async {
    final snapshots = await collectionReference().get();
    for (final transactionDoc in snapshots.docs) {
      await transactionDoc.reference.delete();
    }
  }

  // Scheduled Transactions

  Future<void> addOrUpdateScheduledTransaction(
    ScheduledTransaction scheduledTransaction,
  ) async {
    final scheduledTransactionDTO =
        ScheduledTransactionDto.fromDomain(scheduledTransaction);
    final transactionSnapshot = await scheduledCollectionReference()
        .where('id', isEqualTo: scheduledTransaction.transaction.id.value)
        .get();

    if (transactionSnapshot.docs.isNotEmpty) {
      collectionReference()
          .doc(transactionSnapshot.docs[0].reference.id)
          .update(scheduledTransactionDTO.toFirebaseMap());
    } else {
      collectionReference().add(scheduledTransactionDTO.toFirebaseMap());
    }
  }

  Stream<Option<List<ScheduledTransaction>>> getScheduledTransactions() async* {
    yield* scheduledCollectionReference()
        .orderBy('id', descending: false)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final scheduledTransactionsData = snapshot.docs
            .map((snapshot) =>
                ScheduledTransactionDto.fromFirebaseMap(snapshot.data()))
            .toList();
        final scheduledTransactions =
            scheduledTransactionsData.map((dto) => dto.toDomain()).toList();
        return some(scheduledTransactions);
      } else {
        return none();
      }
    });
  }
}
