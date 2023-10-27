import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<String> saveUserInformation(String userName, String email, String selectedProductName) async {
    DocumentReference reference = await _firestore.collection('users').add({
      'userName': userName,
      'email': email,
      'productName': selectedProductName,
      'timestamp': FieldValue.serverTimestamp(),
    });
    return reference.id;
  }
  Future<void> updateProductName(String documentId, String productName) async {
    await _firestore.collection('users').doc(documentId).update(
      {
        'productName': productName,
      },
    );
  }
}



