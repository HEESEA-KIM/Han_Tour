import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDisplayPage extends StatefulWidget {
  final String docId; // Using the document ID from Firestore as the unique identifier

  QRCodeDisplayPage({Key? key, required this.docId}) : super(key: key);

  @override
  _QRCodeDisplayPageState createState() => _QRCodeDisplayPageState();
}

class _QRCodeDisplayPageState extends State<QRCodeDisplayPage> {
  late String qrData;

  @override
  void initState() {
    super.initState();
    // Constructing the URL based on the document ID
    qrData = "https://nomadmate.web.app/users?docId=${widget.docId}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20),
            Text(
              "You can check reservation information by scanning the QR code!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}