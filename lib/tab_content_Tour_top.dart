import 'package:flutter/material.dart';
import 'package:hanstour/firestore_data.dart';
import 'product_detail.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hanstour/global.dart';

class TourTopContent extends StatefulWidget {
  const TourTopContent({Key? key}) : super(key: key);

  @override
  _TourTopContentState createState() => _TourTopContentState();
}

class _TourTopContentState extends State<TourTopContent> {
  String? savedDocumentId;
  Position? currentPosition;
  Map<String, String>? selectedProduct;

  final textStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    // FutureBuilder를 사용하여 현재 위치 정보를 가져옵니다.
    return FutureBuilder<Position>(
      future: Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium),
      builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('위치 정보를 가져오는데 실패했습니다.'));
        } else if (snapshot.hasData) {
          currentPosition = snapshot.data; // 위치 정보를 갱신합니다.
          return _buildMainContent(); // 주요 컨텐츠 구성
        } else {
          return Center(child: Text('위치 정보를 가져오지 못했습니다.'));
        }
      },
    );
  }

  Widget _buildMainContent() {
    if (selectedProduct != null) {
      // 선택된 제품에서 위도와 경도를 추출
      double latitude = double.parse(selectedProduct!['latitude']!);
      double longitude = double.parse(selectedProduct!['longitude']!);

      // ProductDetailPage에 위도와 경도를 전달
      return ProductDetailPage(
        currentPosition: currentPosition!,
        imagePath: selectedProduct!['imagePath']!,
        imagePath2: selectedProduct!['imagePath2']!,
        imagePath3: selectedProduct!['imagePath3']!,
        productName: selectedProduct!['name']!,
        productLocation: selectedProduct!['location']!,
        productPrice: selectedProduct!['price']!,
        productDescription: selectedProduct!['description']!,
        productExplanation: selectedProduct!['explanation']!,
        operationtime: selectedProduct!['operationtime']!,
        // 운영 시간,요일
        latitude: latitude,
        // 위도 전달
        longitude: longitude, // 경도 전달
      );
    }
    // 선택된 제품이 없을 경우 제품 목록을 보여줍니다.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildInkWells(),
          ),
        ),
      ),
    );
  }

  void selectProduct(Map<String, String> product) async {
    setState(() {
      selectedProduct = product;
    });
    // 전역 변수에 선택된 제품의 name 값을 저장(즉시 아니고 임시저장).
    selectedProductName = product['name'];
    selectedProductLocation = product['location'];

    // 현재 위치 정보와 함께 Firestore에 저장
    if (currentPosition != null) {
      String documentId = await FirestoreService().saveProductInformation(
        product['name']!,
        currentPosition!,
      );
      savedDocumentId = documentId; // 나중에 업데이트를 위해 문서 ID 저장
    }
  }

  void updateSelectedProductNameInFirestore(
      String documentId, String? productName) {
    if (productName != null) {
      FirestoreService().updateProductName(documentId, productName);
    }
  }

  List<Widget> _buildInkWells() {
    final contents = [
      {
        'imagePath': 'assets/contents/Tour_top/gyeongbokgung/Gyeongbokgung.png',
        'imagePath2':
            'assets/contents/Tour_top/gyeongbokgung/Gyeongbokgung2.png',
        'imagePath3':
            'assets/contents/Tour_top/gyeongbokgung/Gyeongbokgung3.png',
        'name': 'Gyeongbokgung Palace',
        'category': 'Tour',
        'location': 'Gyeongbokgung Palace, 161 Sajik-ro, Jongno-gu, Seoul',
        'price': '₩12900',
        'description':
            'an important historical site \n beautiful scenery even at night \n A place where you can learn Korean history',
        'explanation':
            "A palace built in the early Joseon Dynasty in Sejong-ro, Jongno-gu, Seoul and used as a royal palace. a royal palace.",
        'latitude': "37.577565988721304",
        'longitude': "126.97691146775416",
        'operationtime': "Open all year round \nfrom 09:00 am to 17:00 pm",
      },
      {
        'imagePath':
            'assets/contents/Tour_top/artgallery/Hongik University.png',
        'imagePath2':
            'assets/contents/Tour_top/artgallery/Hongik University2.png',
        'imagePath3':
            'assets/contents/Tour_top/artgallery/Hongik University3.png',
        'name': 'Hongik Museum of Art',
        'category': 'ART MUSEUM',
        'location':
            '94, Wausan-ro, Mapo-gu, Seoul, 2nd floor of Hongik University Hongmun Hall',
        'price': '₩8000',
        'description':
            "Introducing trends in contemporary art through special exhibitions and invitations\n Providing a venue for presentation of works to promising active writers \n Providing a place for community art and culture education",
        'explanation':
            'As the central university of contemporary art education in Korea, it is a place that provides experiments and experiences of contemporary art.',
        'latitude': "37.55258005778728",
        'longitude': "126.92497177250269",
        'operationtime':
            "Subsection 1: Open all year round from 10:00 am to 17:00 pm"
                "Subsection 2: Open all year round from 10:00 am to 18:00 pm",
      },
      {
        'imagePath': 'assets/contents/Tour_top/arder/arder.png',
        'imagePath2': 'assets/contents/Tour_top/arder/arder2.png',
        'imagePath3': 'assets/contents/Tour_top/arder/arder3.png',
        'name': 'Arder Error',
        'category': 'EDITING SHOP',
        'location': '19-18 Wausan-ro 21-gil, Mapo-gu, Seoul',
        'price': '₩Free',
        'description':
            'a unique interior\n visual pleasure \n It`s like expressing another dimension',
        'explanation':
            "It is a showroom containing Arthur's unique fashion philosophy and is a place where you can enjoy various clothes and exhibitions at once.",
        'latitude': "37.551706688143014",
        'longitude': "126.92241222933296",
        'operationtime': "Open all year round \nfrom 13:00 pm to 21:00 pm",
      }
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
                  currentPosition: currentPosition!,
                  imagePath: content['imagePath']!,
                  imagePath2: content['imagePath2']!,
                  imagePath3: content['imagePath3']!,
                  productName: content['name']!,
                  productLocation: content['location']!,
                  productPrice: content['price']!,
                  productDescription: content['description']!,
                  productExplanation: content['explanation']!,
                  latitude: double.parse(content['latitude']!),
                  longitude: double.parse(content['longitude']!),
                  operationtime: content['operationtime']!,
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
          content['operationtime']!,
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
      String operationtime,
      String description,
      String explanation) {
    return Column(
      children: <Widget>[
        buildImageWithBookmark(context, imagePath),
        SizedBox(height: 20),
        buildNameWithReviews(name),
        SizedBox(height: 20),
        buildCategoryWithReviews(category),
        SizedBox(height: 13),
        buildLocation(location),
        SizedBox(
          height: 10,
        ),
        buildoperationtime(operationtime),
        buildHighlightText(explanation),
        buildPrice(price),
      ], // time, distance 지움, location 추가, SizedBox 삭제
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

  Widget buildCategoryWithReviews(String category) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildLocation(String location) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 50,
          child: RichText(
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            strutStyle: StrutStyle(fontSize: 13),
            text: TextSpan(
                text: location,
                style: TextStyle(fontSize: 17, color: Colors.grey)),
          ),
        ), //SizedBox 추가
      ],
    );
  }

  Widget buildoperationtime(String operationtime) {
    return SizedBox(
      height: 46,
      width: 310,
      child: Text(
        operationtime,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17, color: Colors.blue),
      ),
    );
  }

  Container buildImageWithBookmark(BuildContext context, String imagePath) {
    return Container(
      width: 330,
      height: 190,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  Column buildHighlightText(String explanation) {
    return Column(
      children: [
        SizedBox(
          height: 17,
        ),
        SizedBox(
          width: 310,
          height: 100,
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
            textAlign: TextAlign.start,
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
