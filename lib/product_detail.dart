import 'package:flutter/material.dart';
import 'package:hanstour/user_information.dart';

class ProductDetailPage extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String productLocation;
  final String productPrice;
  final String productDescription;

  const ProductDetailPage({
    required this.imagePath,
    required this.productName,
    required this.productLocation,
    required this.productPrice,
    required this.productDescription,
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: 530,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 7,
                ),
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
    );
  }

  Widget _buildProductImage() {
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProductText(String text,
      {double fontSize = 20, FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, color: Colors.black, fontWeight: fontWeight),
      textAlign: TextAlign.center,
    );
  }

  Widget _verticalSpacing(double height) {
    return SizedBox(height: height);
  }

  Widget _buildPurchaseButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: OwnerAuthentication()),
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
    );
  }
}
