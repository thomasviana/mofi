// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mofi/core/user/domain.dart';
// import 'package:mofi/di/dependency_injection.dart';

// extension FirestoreX on FirebaseFirestore {
//   Future<DocumentReference> userDocument() async {
//     final user = await sl<AuthService>().getUser().first;
//     if (user != null) {}
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.id.getOrCrash());
//   }
// }

// extension DocumentReferenceX on DocumentReference {
//   CollectionReference get noteCollection => collection('notes');
// }
