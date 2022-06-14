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

  Future<void> addOrUpdateCategory(Category category) async {
    final ref =
        _firebaseFirestore.collection('users/${currentUser!.uid}/categories');

    final categoryDTO = CategoryDto.fromDomain(category);
    final categorySnapshot =
        await ref.where('id', isEqualTo: category.id.value).get();

    if (categorySnapshot.docs.isNotEmpty) {
      await ref
          .doc(categorySnapshot.docs[0].reference.id)
          .update(categoryDTO.toFirebaseMap());
    } else {
      await ref.add(categoryDTO.toFirebaseMap());
    }
  }

  // Future<void> updateCategory(Category category) async {
  //   final ref = _firebaseFirestore
  //       .collection('users/${currentUser!.uid}/categories')
  //       .doc(category.id.value);
  //   final categoryDTO = CategoryDto.fromDomain(category);
  //   await ref.update(categoryDTO.toFirebaseMap());
  // }

  Stream<Option<List<Category>>> getCategories() async* {
    yield* _firebaseFirestore
        .collection('users/${currentUser!.uid}/categories')
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
    final ref = _firebaseFirestore
        .collection('users/${currentUser!.uid}/categories')
        .doc(categoryId.value);
    await ref.delete();
  }

  Future<void> deleteAllCategories() async {
    final snapshots = await _firebaseFirestore
        .collection('users/${currentUser!.uid}/categories')
        .get();
    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> saveSubCategory(SubCategory subCategory) async {
    final ref = _firebaseFirestore.collection(
      'users/${currentUser!.uid}/categories/${subCategory.categoryId}',
    );
    final subCategoryDTO = SubCategoryDto.fromDomain(subCategory);
    await ref.add(subCategoryDTO.toFirebaseMap());
  }

  Stream<Option<List<SubCategory>>> getAllSubCategories() async* {
    yield* _firebaseFirestore
        .collection('users/${currentUser!.uid}/categories')
        .snapshots()
        .map((snapshot) {
      List<SubCategory> subCategories = [];
      for (final doc in snapshot.docs) {
        final snapshots = doc.get('subCategories')
            as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
        if (snapshots.isNotEmpty) {
          final subSategoriesData = snapshots
              .map(
                (snapshot) => SubCategoryDto.fromFirebaseMap(snapshot.data()),
              )
              .toList();
          subCategories =
              subSategoriesData.map((dto) => dto.toDomain()).toList();
        }
      }
      return optionOf(subCategories);
    });
  }

  Stream<Option<List<SubCategory>>> getSubCategoriesByCategory(
    CategoryId categoryId,
  ) async* {
    yield* _firebaseFirestore
        .collection(
          'users/${currentUser!.uid}/categories/$categoryId/subCategories',
        )
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
    final ref = _firebaseFirestore
        .collection(
          'users/${currentUser!.uid}/categories/${subCategory.categoryId}}/subCategories',
        )
        .doc(subCategory.id.value);
    await ref.delete();
  }

  Future<void> deleteAllSubCategories() async {
    final snapshots = await _firebaseFirestore
        .collection('users/${currentUser!.uid}/categories')
        .get();
    for (final doc in snapshots.docs) {
      final reference = (doc.data()['subCategories']
              as QueryDocumentSnapshot<Map<String, dynamic>>)
          .reference;
      await reference.delete();
    }
  }
}
