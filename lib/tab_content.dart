import 'package:flutter/material.dart';
import 'product_detail.dart';

class TabContent extends StatefulWidget {
  const TabContent({Key? key}) : super(key: key);

  @override
  _TabContentState createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
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
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
        'imagePath': 'assets/contents/everland2.png',
        'name': 'Everland',
        'category': 'THEME PARKS',
        'location': 'Do in Gyeionggi-do',
        'price': '\$24.56',
        'distance': '10Km',
        'description':
            "Korea's largest theme park operated by Samsung, located in Yongin-si, Gyeonggi-do."
      },
      {
        'imagePath': 'assets/contents/aqualium.png',
        'name': 'Aqualium',
        'category': 'AQUARIUM',
        'location': 'Do in Seoul',
        'price': '\$19.25',
        'distance': '5Km',
        'description':
            "One of Korea's representative aquariums with the title of 'Korea's largest shark habitat'",
      },
      {
        'imagePath': 'assets/contents/nanta.png',
        'name': 'Nanta',
        'category': 'PERFORMANCES',
        'location': '& Shows in Seoul',
        'price': '\$22.83',
        'distance': '8Km',
        'description':
            "Nanta Show is Korea's first non-verbal performance based on Samulnori rhythm, a traditional Korean melody."
      }
    ];

    return contents.map((content) {
      return InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ProductDetailPage(
                    imagePath: content['imagePath']!,
                    productName: content['name']!,
                    productLocation: content['location']!,
                    productPrice: content['price']!,
                    productDescription: content['description']!,
                  ),
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
      String description) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        buildImageWithBookmark(context, imagePath),
        SizedBox(height: 20),
        buildNameWithReviews(name),
        SizedBox(height: 15),
        buildCategoryWithReviews(category),
        SizedBox(height: 15),
        buildLocation(distance),
        SizedBox(height: 10),
        buildHighlightText(location),
        SizedBox(height: 60),
        buildPriceButton(price),
      ],
    );
  }

  Row buildNameWithReviews(String name) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name, style: textStyle),
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

  Row buildLocation(String distance) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('location,  l',
            style: TextStyle(fontSize: 18, color: Colors.grey)),
        SizedBox(width: 10),
        Text(distance, style: TextStyle(fontSize: 18, color: Colors.black87)),
      ],
    );
  }

  Stack buildImageWithBookmark(BuildContext context, String imagePath) {
    return Stack(
      children: [
        buildBookmark(),
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 100,
        ),
      ],
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

  Column buildHighlightText(String text) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.military_tech, color: Colors.orangeAccent),
            Text('No.1 of Top 20 Best Things to',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.orangeAccent)),
          ],
        ),
        Text(text,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.orangeAccent)),
      ],
    );
  }

  ElevatedButton buildPriceButton(String price) {
    return ElevatedButton(
      onPressed: () => print('구매버튼'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
        ),
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
