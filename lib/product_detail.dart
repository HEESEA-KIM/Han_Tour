import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hanstour/qrcode.dart';
import 'firestore_data.dart';

class ProductDetailPage extends StatefulWidget {
  final String imagePath;
  final String imagePath2;
  final String imagePath3;
  final String productName;
  final String productLocation;
  final String productPrice;
  final String productDescription;
  final String productExplanation;
  final String operationtime;
  final Position currentPosition;
  final double latitude;
  final double longitude;

  const ProductDetailPage({
    required this.imagePath,
    required this.imagePath2,
    required this.imagePath3,
    required this.productName,
    required this.productLocation,
    required this.productPrice,
    required this.productDescription,
    required this.productExplanation,
    required this.operationtime,
    required this.currentPosition,
    required this.latitude,
    required this.longitude,
    Key? key,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController controller = PageController(
    viewportFraction: 0.8,
    initialPage: 1000,
  );
  int currentPage = 1000;

  @override
  void initState() {
    super.initState();
    controller.addListener(
      () {
        if (controller.page != null) {
          int next = controller.page!.round();
          if (currentPage != next) {
            setState(() {
              currentPage = next;
            });
          }
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildProductImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 550,
          child: PageView.builder(
            controller: controller,
            itemCount: null,
            itemBuilder: (context, index) {
              final int imageIndex = index % 3;
              String imagePath;
              switch (imageIndex) {
                case 0:
                  imagePath = widget.imagePath;
                  break;
                case 1:
                  imagePath = widget.imagePath2;
                  break;
                case 2:
                  imagePath = widget.imagePath3;
                  break;
                default:
                  imagePath = widget.imagePath;
              }
              return Image.asset(
                imagePath,
                fit: BoxFit.fitHeight,
              );
            },
          ),
        ),
        // 인디케이터 추가
        Positioned(
          bottom: 10.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(3, (index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      currentPage % 3 == index ? Colors.blue : Colors.grey[300],
                ),
              );
            }),
          ),
        ),
        // 왼쪽 화살표 버튼
        Positioned(
          left: 110,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 50,
              color: Colors.blue,
            ),
            onPressed: () {
              // 현재 페이지 인덱스를 감소시켜 이전 페이지로 이동합니다.
              controller.previousPage(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        // 오른쪽 화살표 버튼
        Positioned(
          right: 110,
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 50,
              color: Colors.blue,
            ),
            onPressed: () {
              // 현재 페이지 인덱스를 증가시켜 다음 페이지로 이동합니다.
              controller.nextPage(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ],
    );
  }

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
                height: 920,
                child: Center(
                  // Column 위젯을 사용하여 상품 정보를 세로로 나열합니다.
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildProductImage(),
                      _verticalSpacing(10),
                      _buildProductText(widget.productName,
                          fontSize: 30, fontWeight: FontWeight.bold),
                      _verticalSpacing(7),
                      _buildProductText(
                        widget.productDescription,
                        fontSize: 23,
                      ),
                      _verticalSpacing(15),
                      _buildProductText(
                        widget.productLocation,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      _verticalSpacing(13),
                      _buildProductText(widget.productPrice,
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
            String documentId =
                await firestoreService.saveQrcodeLocationInformation(
                    widget.productName, widget.currentPosition);

            // QRCodeDisplayPage로 화면 전환과 동시에 위치 정보와 문서 ID를 전달합니다.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => QRCodeDisplayPage(
                  currentPosition: widget.currentPosition,
                  latitude: widget.latitude,
                  longitude: widget.longitude,
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
