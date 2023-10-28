import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<String> saveUserInformation(String userName, String email, String selectedProductName, String selectedProductLocation) async {
    DocumentReference reference = await _firestore.collection('users').add({
      'userName': userName,
      'email': email,
      'productName': selectedProductName,
      'location': selectedProductLocation,
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



