import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationDetailsPage extends StatefulWidget {
  final String url;  // The URL obtained from scanning the QR code

  ReservationDetailsPage({required this.url});

  @override
  _ReservationDetailsPageState createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? reservationDetails;

  @override
  void initState() {
    super.initState();
    print("initState called");
    _fetchReservationDetails();
  }

  // Parse the URL and fetch reservation details from Firestore
  Future<void> _fetchReservationDetails() async {
    Uri parsedUrl = Uri.parse(widget.url);
    String? docId = parsedUrl.queryParameters['docId'];
    print("Fetched docId from URL: $docId");
    if (docId != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(docId).get();
      if (doc.exists) {
        reservationDetails = doc.data() as Map<String, dynamic>;
        setState(() {});  // Rebuild the widget with the fetched data
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: reservationDetails != null
            ? Text("Reservation Details: ${reservationDetails.toString()}")
            : CircularProgressIndicator(),
      ),
    );
  }
}