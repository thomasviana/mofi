import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/budgets/domain.dart';
import 'package:mofi/core/budgets/infrastructure.dart';

@lazySingleton
class BudgetsFirebaseProvider {
  final FirebaseFirestore _firebaseFirestore;

  BudgetsFirebaseProvider(
    this._firebaseFirestore,
  );

  User? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception.');
    return user;
  }

  // BUDGETS

  Future<void> addOrUpdateBudget(Budget budget) async {
    final ref =
        _firebaseFirestore.collection('users/${currentUser!.uid}/budgets');

    final budgetDTO = BudgetDto.fromDomain(budget);
    final budgetSnapshot =
        await ref.where('id', isEqualTo: budget.id.value).get();

    if (budgetSnapshot.docs.isNotEmpty) {
      await ref
          .doc(budgetSnapshot.docs[0].reference.id)
          .update(budgetDTO.toFirebaseMap());
    } else {
      await ref.add(budgetDTO.toFirebaseMap());
    }
  }

  Stream<Option<List<Budget>>> getBudgets() async* {
    yield* _firebaseFirestore
        .collection('users/${currentUser!.uid}/budgets')
        .orderBy('id', descending: false)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final budgetsData = snapshot.docs
            .map((snapshot) => BudgetDto.fromFirebaseMap(snapshot.data()))
            .toList();
        final budgets = budgetsData.map((dto) => dto.toDomain()).toList();
        return some(budgets);
      } else {
        return none();
      }
    });
  }

  Future<void> deleteBudget(BudgetId budgetId) async {
    final ref = _firebaseFirestore
        .collection('users/${currentUser!.uid}/budgets')
        .doc(budgetId.value);
    await ref.delete();
  }

  Future<void> deleteAllBudgets() async {
    final snapshots = await _firebaseFirestore
        .collection('users/${currentUser!.uid}/budgets')
        .get();
    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
