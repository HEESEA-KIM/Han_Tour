import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void purchaseProduct(Product product) async {
    DocumentReference reference = await _firestore.collection('products').add({
      'productName': product.name,
      'productPrice': product.price,
      'productDescription': product.description,
      // ... 다른 필요한 필드 추가
    });

    print("Saved product with ID: ${reference.id}");
  }
  void fetchProductInfo(String productId) async {
    DocumentSnapshot snapshot = await _firestore.collection('products').doc(productId).get();
    if (snapshot.exists) {
      Map<String, dynamic> productData = snapshot.data() as Map<String, dynamic>;
      // productData에서 상품 정보를 추출하고 사용합니다.
    } else {
      print("Product not found!");
    }
  }
}
class Product {
  String id; // Firestore 문서 ID
  String name;
  double price;
  String description;
  String imageUrl;
  // 기타 필요한 속성 추가

  // 기본 생성자
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    // 기타 필요한 속성 초기화
  });

  // Firestore 문서를 Product 객체로 변환하는 팩토리 메서드
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'],
      price: data['price'].toDouble(),
      description: data['description'],
      imageUrl: data['imageUrl'],
      // 기타 필요한 속성 초기화
    );
  }

  // Product 객체를 Map으로 변환하는 메서드 (Firestore에 저장하기 위해)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      // 기타 필요한 속성 추가
    };
  }

// 기타 필요한 메서드 추가
}
