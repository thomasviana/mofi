import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/categories/domain.dart';
import 'package:mofi/core/categories/infrastructure.dart';

@lazySingleton
class CategoriesFirebaseProvider {
  final FirebaseFirestore _firebaseFirestore;

  CategoriesFirebaseProvider(
    this._firebaseFirestore,
  );

  User? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception.');
    return user;
  }

  CollectionReference<Map<String, dynamic>> collectionReference() =>
      _firebaseFirestore.collection('users/${currentUser!.uid}/categories');

  // CATEGORIES

  Future<void> addOrUpdateCategory(Category category) async {
    final categoryDTO = CategoryDto.fromDomain(category);
    final categorySnapshot = await collectionReference()
        .where('id', isEqualTo: category.id.value)
        .get();

    if (categorySnapshot.docs.isNotEmpty) {
      collectionReference()
          .doc(categorySnapshot.docs[0].reference.id)
          .update(categoryDTO.toFirebaseMap());
    } else {
      collectionReference().add(categoryDTO.toFirebaseMap());
    }
  }

  Stream<Option<List<Category>>> getCategories() async* {
    yield* collectionReference()
        .orderBy('id', descending: false)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final categoriesData = snapshot.docs
            .map((snapshot) => CategoryDto.fromFirebaseMap(snapshot.data()))
            .toList();
        final categories = categoriesData.map((dto) => dto.toDomain()).toList();
        return some(categories);
      } else {
        return none();
      }
    });
  }

  Future<void> deleteCategory(CategoryId categoryId) async {
    final categorySnapshot = await collectionReference()
        .where('id', isEqualTo: categoryId.value)
        .get();

    if (categorySnapshot.docs.isEmpty) return;
    final categoryReferenceId = categorySnapshot.docs[0].reference.id;
    collectionReference().doc(categoryReferenceId).delete();
  }

  Future<void> deleteAllCategories() async {
    final snapshots = await collectionReference().get();
    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  // SUBCATEGORIES

  Future<void> addOrUpdateSubCategory(SubCategory subCategory) async {
    final subCategoryDTO = SubCategoryDto.fromDomain(subCategory);
    final categorySnapshot = await collectionReference()
        .where('id', isEqualTo: subCategory.categoryId.value)
        .get();
    if (categorySnapshot.docs.isEmpty) return;
    final categoryReferenceId = categorySnapshot.docs[0].reference.id;
    final ref = collectionReference()
        .doc(categoryReferenceId)
        .collection('subCategories');
    final subCategorySnapshot =
        await ref.where('id', isEqualTo: subCategory.id.value).get();

    if (subCategorySnapshot.docs.isNotEmpty) {
      ref
          .doc(subCategorySnapshot.docs[0].reference.id)
          .update(subCategoryDTO.toFirebaseMap());
    } else {
      ref.add(subCategoryDTO.toFirebaseMap());
    }
  }

  Stream<Option<List<SubCategory>>> getSubCategoriesByCategory(
    CategoryId categoryId,
  ) async* {
    final categorySnapshot = await collectionReference()
        .where('id', isEqualTo: categoryId.value)
        .get();

    if (categorySnapshot.docs.isEmpty) return;
    final categoryReferenceId = categorySnapshot.docs[0].reference.id;

    yield* collectionReference()
        .doc(categoryReferenceId)
        .collection('subCategories')
        .orderBy('id', descending: false)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final subCategoriesData = snapshot.docs
            .map((snapshot) => SubCategoryDto.fromFirebaseMap(snapshot.data()))
            .toList();
        final subCategories =
            subCategoriesData.map((dto) => dto.toDomain()).toList();
        return some(subCategories);
      } else {
        return none();
      }
    });
  }

  Future<void> deleteSubCategory(SubCategory subCategory) async {
    final categorySnapshot = await collectionReference()
        .where('id', isEqualTo: subCategory.categoryId.value)
        .get();

    if (categorySnapshot.docs.isEmpty) return;
    final categoryReferenceId = categorySnapshot.docs[0].reference.id;
    final ref = collectionReference()
        .doc(categoryReferenceId)
        .collection('subCategories');

    final subCategorySnapshot =
        await ref.where('id', isEqualTo: subCategory.id.value).get();

    if (subCategorySnapshot.docs.isNotEmpty) {
      ref.doc(subCategorySnapshot.docs[0].reference.id).delete();
    }
  }

  Future<void> deleteAllSubCategories() async {
    final snapshots = await collectionReference().get();
    for (final categoryDoc in snapshots.docs) {
      final categoryReferenceId = categoryDoc.reference.id;
      collectionReference()
          .doc(categoryReferenceId)
          .collection('subCategories')
          .get()
          .then(
        (snapshot) {
          for (final doc in snapshot.docs) {
            doc.reference.delete();
          }
        },
      );
    }
  }
}
