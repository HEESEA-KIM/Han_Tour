import 'package:flutter/material.dart';
import 'package:hanstour/firestore_data.dart';
import 'product_detail.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hanstour/global.dart';

class ActivityMostContent extends StatefulWidget {
  const ActivityMostContent({Key? key}) : super(key: key);

  @override
  _ActivityMostContentState createState() => _ActivityMostContentState();
}

class _ActivityMostContentState extends State<ActivityMostContent> {
  late ScrollController _controller;
  @override

  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      // 스크롤 할 때 마다 호출

      // 스크롤 된 값
      print('offset : ${_controller.offset}');

      // 스크롤에 대한 여러 정보를 가지고 있음
      // 전체 길이, offset, 방향 등
      print('position : ${_controller.position}');
      // 컨트롤러가 SingleChildScrollView에 연결이 됐는지 안됐는지
      _controller.hasClients;
    });
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? savedDocumentId;

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  void selectProduct(Map<String, String> product) {
    setState(() {
      selectedProduct = product;
    });
    // 전역 변수에 선택된 제품의 name 값을 저장(즉시 아니고 임시저장).
    selectedProductName = product['name'];
    selectedProductLocation = product['location'];
    // Firestore에 선택된 제품의 name 값을 저장(즉시저장).
    if (savedDocumentId != null) {
      updateSelectedProductNameInFirestore(savedDocumentId!, product['name']);
    }
  }

  void updateSelectedProductNameInFirestore(
      String documentId, String? productName) {
    if (productName != null) {
      FirestoreService().updateProductName(documentId, productName);
    }
  }

  final textStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black);
  Map<String, String>? selectedProduct;

  @override
  Widget build(BuildContext context) {
    if (selectedProduct != null) {
      return ProductDetailPage(
        imagePath: selectedProduct!['imagePath']!,
        productName: selectedProduct!['name']!,
        productLocation: selectedProduct!['location']!,
        productPrice: selectedProduct!['price']!,
        productDescription: selectedProduct!['description']!,
        productExplanation: selectedProduct!['explanation']!,
      );// time, distance 지움
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildInkWells(),
            ),
      ),
    );
  }

  List<Widget> _buildInkWells() {
    final contents = [
      {
        'imagePath': 'assets/contents/rental.png',
        'name': 'anyone School uniform rental',
        'category': 'RENTAL',
        'location': '5th floor of Jinyuwon Building, 55,\n Wausan-ro 35-gil, Mapo-gu, Seoul',
        'price': '₩25000',
        'description':
        'Kpop Celebrity Uniform Experience\n an indoor studio \n Various props and directing',
        'explanation':
        "It is a place where you can experience the uniforms of Kpop celebrities and enjoy various pictures and beautiful memories."
      },
      {
        'imagePath': 'assets/contents/hongik.png',
        'name': 'Hongik University Street',
        'category': 'A TOURIST ATTRACTION',
        'location': 'Seogyo-dong, Mapo-gu, Seoul',
        'price': '₩Free',
        'description':
        "Various events and street performances\n a small shop and a fashion shop \n cultural elements such as festivals",
        'explanation':
        'Hongik University has a variety of cultural elements and is rich in attractions and food.',
      },
      {
        'imagePath': 'assets/contents/Playstation.png',
        'name': 'Hongik University Lounge Play Store',
        'category': 'PLAYSTATION ROOM',
        'location': '5th floor of Hongseok Building,\n 12 Xandari-ro, Mapo-gu, Seoul',
        'price': '₩3000',
        'description':
        'Various games\n a couple`s unique date \n a comfortable and pleasant environment',
        'explanation':
        "Couples or friends can enjoy various games as a good place to play and enjoy together."
      },
      {
        'imagePath': 'assets/contents/massage.png',
        'name': 'Himawari Massage & Cafe',
        'category': 'SPA',
        'location': '28-7, Wausan-ro 21-gil, Mapo-gu, Seoul',
        'price': '₩55000',
        'description':
        'an exotic date course \n relieving fatigue \n a sincere massage',
        'explanation':
        "An unusual place to relieve the exhaustion of a day-to-day exhaustion."
      },
    ];

    return contents.map((content) {
      return InkWell(
        onTap: () async {
          // 선택된 제품의 name 값을 Firestore에 저장
          selectProduct(content);
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.7,
                child: ProductDetailPage(
                  imagePath: content['imagePath']!,
                  productName: content['name']!,
                  productLocation: content['location']!,
                  productPrice: content['price']!,
                  productDescription: content['description']!,
                  productExplanation: content['explanation']!,
                ),
              );
            },
          );
          // 다이얼로그가 닫힌 후에 selectedProduct를 초기화하고 UI를 업데이트합니다.
          setState(
                () {
              selectedProduct = null;
            },
          );
        },
        child: buildColumn(
          context,
          content['imagePath']!,
          content['name']!,
          content['category']!,
          content['location']!,
          content['price']!,
          content['description']!,
          content['explanation']!,
        ),
      );
    }).toList();
  }

  Column buildColumn(
      BuildContext context,
      String imagePath,
      String name,
      String category,
      String location,
      String price,
      String description,
      String explanation) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        buildImageWithBookmark(context, imagePath),
        SizedBox(height: 20),
        buildNameWithReviews(name),
        SizedBox(height: 20),
        buildCategoryWithReviews(category),
        SizedBox(height: 20),
        buildLocation(location),
        buildHighlightText(explanation),
        buildPrice(price),
      ], // time, distance 지움, location 추가
    );
  }

  Row buildNameWithReviews(String name) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 15)
      ],
    );
  }

  Row buildCategoryWithReviews(String category) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCategoryCard(category),
      ],
    );
  }

  Card buildCategoryCard(String text) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue),
        ),
      ),
    );
  }

  Row buildLocation(String location) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          strutStyle: StrutStyle(fontSize: 13),
          text: TextSpan(
              text: location,
              style: TextStyle(fontSize: 13, color: Colors.grey)),
        ),
        SizedBox(height: 30,),
      ],
    );
  }

  Container buildImageWithBookmark(BuildContext context, String imagePath) {
    return Container(
      width: 290,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  Stack buildBookmark() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: 4.7,
          child: Icon(Icons.bookmark, color: Color(0XFFdfd2d2), size: 120),
        ),
        Text('Grade',
            style: TextStyle(fontSize: 16, color: Colors.orangeAccent)),
        Positioned(
            left: 15, child: Icon(Icons.star, color: Colors.orangeAccent)),
      ],
    );
  }

  Column buildHighlightText(String explanation) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF322dbd))),
          ],
        ),
        SizedBox(
          width: 300,
          height: 100,
          child: Flexible(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              strutStyle: StrutStyle(fontSize: 15),
              text: TextSpan(
                text: explanation,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF357ca7),
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPrice(String price) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text('From', style: TextStyle(fontSize: 20, color: Colors.white)),
          SizedBox(width: 10),
          Text(price, style: TextStyle(fontSize: 32, color: Colors.white)),
        ],
      ),
    );
  }
}
