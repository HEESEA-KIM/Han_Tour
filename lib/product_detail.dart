import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hanstour/user_information.dart';
import 'package:hanstour/qrcode.dart';

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
            child: SingleChildScrollView(
              child: SizedBox(
                height: 1000,
                child: Center(
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
                      _verticalSpacing(10),
                      _buildProductText(
                        productLocation,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      _verticalSpacing(7),
                      _buildProductText(productPrice,
                          fontSize: 28, fontWeight: FontWeight.bold),
                      _verticalSpacing(8),
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
      width: 1250,
      height: 470,
      child: Image.asset(
        imagePath,
        width: 550,
        height: 200,
        fit: BoxFit.fill,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QRCodeDisplayPage(
            currentPosition: currentPosition,
            latitude: latitude,
            longitude: longitude), // QR 코드 위젯
        SizedBox(width: 200), // 버튼과 QR 코드 사이의 간격 조정
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: OwnerAuthentication(),
                  ),
                );
              },
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Purchase',
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
