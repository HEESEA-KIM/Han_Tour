import 'package:flutter/material.dart';

TextStyle commonTextStyle =
TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black);

Widget buildNameWithReviews(String name) {
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
  return Row(
    textDirection: TextDirection.ltr,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildCategoryCard(category),
    ],
  );
}

Widget buildCategoryCard(String text) {
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

Widget buildLocation(String location) {
  return Row(
    textDirection: TextDirection.ltr,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 300,
        height: 30,
        child: RichText(
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          strutStyle: StrutStyle(fontSize: 13),
          text: TextSpan(
              text: location,
              style: TextStyle(fontSize: 13, color: Colors.grey)),
        ),
      ),
    ],
  );
}

Widget buildImageWithBookmark(BuildContext context, String imagePath) {
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

Widget buildHighlightText(String explanation) {
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
        width: 310,
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
