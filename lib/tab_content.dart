import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Contents(),
    );
  }
}

class Contents extends StatefulWidget {
  const Contents({super.key});

  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  final textStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildColumn(context, 'assets/contents/everland2.png', 'Everland',
                'THEME PARKS', 'Do in Gyeionggi-do', '\$ 24.56', '10Km'),
            buildColumn(context, 'assets/contents/aqualium.png', 'Aqualium',
                'AQUARIUM', 'Do in Seoul', '\$ 19.25', '5Km'),
            buildColumn(context, 'assets/contents/nanta.png', 'Nanta',
                'PERFORMANCES', '& Shows in Seoul', '\$ 22.83', '8Km'),
          ],
        ),
      ),
    );
  }

  Column buildColumn(BuildContext context, String imagePath, String name,
      String category, String location, String price, String distance) {
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
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
        ),),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 10.0,horizontal: 25),
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
