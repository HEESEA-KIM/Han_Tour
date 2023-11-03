import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_flutter/qr_flutter.dart';

// QR 코드를 표시하는 위젯 페이지 클래스입니다.
class QRCodeDisplayPage extends StatefulWidget {
  final Position currentPosition; // 현재 위치 정보를 저장하는 변수입니다.
  final double latitude; // 위도 정보를 저장하는 변수입니다.
  final double longitude; // 경도 정보를 저장하는 변수입니다.

  // 생성자에서 현재 위치 정보를 받습니다.
  QRCodeDisplayPage({Key? key, required this.currentPosition, required this.latitude, required this.longitude}) : super(key: key);

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // QR 코드 이미지를 표시합니다.
        QrImageView( // QrImageView 대신 실제 QR 코드 위젯을 사용하세요.
          data: navigationLink,
          version: QrVersions.auto,
          size: 120.0,
        ),
        // 위치 정보라는 텍스트를 표시합니다.
        Text(
          "Location Information",
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
