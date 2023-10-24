import 'package:flutter/material.dart';
import 'product_detail.dart';
import 'package:geolocator/geolocator.dart';

class TabContent extends StatefulWidget {
  const TabContent({Key? key}) : super(key: key);

  @override
  _TabContentState createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
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
        productTimetaken: selectedProduct!['time']!,
        productExplanation: selectedProduct!['explanation']!,
      );
    }
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

  List<Widget> _buildInkWells() {
    final contents = [
      {
        'imagePath': 'assets/contents/lotteworld.png',
        'name': 'Lotte World',
        'category': 'THEME PARKS',
        'location': '240 Olympic-ro, Songpa-gu, Seoul',
        'price': '\₩33000',
        'distance': '24Km',
        'time': 'about 38 minutes',
        'description':
        'Experience seasonal parades and dynamic attractions at Lotte World, a land of adventure and mystery full of fun 365 days a year.',
        'explanation':
        "Korea's largest theme park operated by Samsung, located in Yongin-si, Gyeonggi-do."
      },
      {
        'imagePath': 'assets/contents/aqualium.png',
        'name': 'Lotte Aqualium',
        'category': 'AQUARIUM',
        'location': '300 Olympic-ro, Songpa-gu, Seoul',
        'price': '\₩25900',
        'distance': '24Km',
        'time': 'about 38 minutes',
        'description':
        'Nature in the city! Come visit Lotte World Aquarium, which dreams of a joyful world where people and nature live together.',
        'explanation':
        "One of Korea's representative aquariums with the title of 'Korea's largest shark habitat'",
      },
      {
        'imagePath': 'assets/contents/nanta.png',
        'name': 'Myeongdong Nanta',
        'category': 'PERFORMANCES',
        'location': 'UNESCO Center, 26 Myeongdong-gil, Jung-gu, Seoul',
        'price': '\₩30700',
        'distance': '2.2Km',
        'time': 'about 11 minutes',
        'description':
        'Since 1997 14.8 million viewers made a reasonable choice! Nanta impressed not only Korea but the world!',
        'explanation':
        "Nanta Show is Korea's first non-verbal performance based on Samulnori rhythm, a traditional Korean melody."
      }
    ];

    return contents.map((content) {
      return InkWell(
        onTap: () {
          showDialog(
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
                  productTimetaken: content['time']!,
                  productExplanation: content['explanation']!,
                ),
              );
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
          content['distance']!,
          content['description']!,
          content['time']!,
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
      String distance,
      String description,
      String time,
      String explanation) {
    return Column(
      children: <Widget>[
        SizedBox(height: 1),
        buildImageWithBookmark(context, imagePath),
        SizedBox(height: 10),
        buildNameWithReviews(name),
        SizedBox(height: 10),
        buildCategoryWithReviews(category),
        SizedBox(height: 10),
        buildLocation(location, distance),
        SizedBox(height: 10),
        buildHighlightText(time, explanation),
        SizedBox(height: 1),
        buildPrice(price),
      ],
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
        SizedBox(width: 15),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text('Reviews',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey)),
        ),
      ],
    );
  }

  Row buildCategoryWithReviews(String category) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCategoryCard(category),
        SizedBox(width: 1),
        buildCategoryCard('reviews'),
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

  Row buildLocation(String location, String distance) {
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
        SizedBox(
          width: 10,
        ),
        Text(distance, style: TextStyle(fontSize: 16, color: Colors.black87)),
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

  Column buildHighlightText(String time, String explanation) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF322dbd))),
          ],
        ),
        SizedBox(
          width: 300,
          height: 140,
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
              ),textAlign: TextAlign.center,
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