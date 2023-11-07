import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hanstour/qrcode.dart';

import 'firestore_data.dart';

class ProductDetailPage extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String productLocation;
  final String productPrice;
  final String productDescription;
  final String productExplanation;
  final Position currentPosition; // 현재 위치 정보
  final double latitude; // 추가된 위도 정보
  final double longitude; // 추가된 경도 정보

  const ProductDetailPage({
    required this.imagePath,
    required this.productName,
    required this.productLocation,
    required this.productPrice,
    required this.productDescription,
    required this.productExplanation,
    required this.currentPosition, // 생성자에 현재 위치 정보를 포함
    required this.latitude, // 생성자에 위도 정보를 포함
    required this.longitude, // 생성자에 경도 정보를 포함

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.blue,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            // SingleChildScrollView를 사용하여 스크롤 가능한 뷰를 생성합니다.
            child: SingleChildScrollView(
              child: SizedBox(
                height: 850,
                child: Center(
                  // Column 위젯을 사용하여 상품 정보를 세로로 나열합니다.
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildProductImage(),
                      _verticalSpacing(10),
                      _buildProductText(productName,
                          fontSize: 30, fontWeight: FontWeight.bold),
                      _verticalSpacing(7),
                      _buildProductText(
                        productDescription,
                        fontSize: 23,
                      ),
                      _verticalSpacing(15),
                      _buildProductText(
                        productLocation,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      _verticalSpacing(13),
                      _buildProductText(productPrice,
                          fontSize: 28, fontWeight: FontWeight.bold),
                      _verticalSpacing(15),
                      _buildPurchaseButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return SizedBox(
      height: 500,
      child: Image.asset(
        imagePath,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _buildProductText(String text,
      {double fontSize = 20, FontWeight fontWeight = FontWeight.normal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: fontSize, color: Colors.black, fontWeight: fontWeight),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _verticalSpacing(double height) {
    return SizedBox(height: height);
  }

  Widget _buildPurchaseButton(BuildContext context) {
    // FirestoreService 인스턴스를 생성합니다.
    final FirestoreService firestoreService = FirestoreService();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            // FirestoreService 인스턴스를 사용하여 위치 정보를 저장하고 문서 ID를 받아옵니다.
            String documentId = await firestoreService
                .saveQrcodeLocationInformation(productName, currentPosition);

            // QRCodeDisplayPage로 화면 전환과 동시에 위치 정보와 문서 ID를 전달합니다.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => QRCodeDisplayPage(
                  currentPosition: currentPosition,
                  latitude: latitude,
                  longitude: longitude,
                  documentId: documentId, // Firestore 문서 ID 전달
                ),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Location Information',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
