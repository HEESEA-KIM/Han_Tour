import 'package:flutter/material.dart';
import 'package:hanstour/user_information.dart';

class ProductDetailPage extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String productLocation;
  final String productPrice;
  final String productDescription;
  final String productTimetaken;
  final String productExplanation;

  const ProductDetailPage({
    required this.imagePath,
    required this.productName,
    required this.productLocation,
    required this.productPrice,
    required this.productDescription,
    required this.productTimetaken,
    required this.productExplanation,
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
                height: 800,
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
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.7,
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
