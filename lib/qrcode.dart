import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_flutter/qr_flutter.dart';

// QR 코드를 표시하는 위젯 페이지 클래스입니다.
class QRCodeDisplayPage extends StatefulWidget {
  final Position currentPosition; // 현재 위치 정보를 저장하는 변수입니다.
  final double latitude; // 위도 정보를 저장하는 변수입니다.
  final double longitude; // 경도 정보를 저장하는 변수입니다.

  // 생성자에서 현재 위치 정보를 받습니다.
  QRCodeDisplayPage({Key? key, required this.currentPosition, required this.latitude, required this.longitude, required String documentId}) : super(key: key);

  @override
  _QRCodeDisplayPageState createState() => _QRCodeDisplayPageState();
}

class _QRCodeDisplayPageState extends State<QRCodeDisplayPage> {
  late String navigationLink; // Google Maps로 네비게이션 링크를 생성합니다.

  @override
  void initState() {
    super.initState();
    // initState에서 네비게이션 링크를 초기화합니다.
    navigationLink =
    "https://www.google.com/maps/dir/?api=1&origin=${widget.currentPosition.latitude},${widget.currentPosition.longitude}&destination=${widget.latitude},${widget.longitude}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 70,),
            // QrImage 위젯을 사용하여 QR 코드를 표시합니다.
            QrImageView(
              data: navigationLink,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 40),
            Text(
              "Location information through Google Maps",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 80,),
            ElevatedButton(
              onPressed: () {
                // 네비게이션 스택에서 첫 번째 화면으로 돌아갑니다.
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'Return to Home',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}