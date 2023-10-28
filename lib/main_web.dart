import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hanstour/firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyWebApp());
}

class MyWebApp extends StatelessWidget {
  const MyWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=> ReservationDetailsPage(),
      },
    );
  }
}



class ReservationDetailsPage extends StatefulWidget {
  const ReservationDetailsPage({super.key});

  @override
  _ReservationDetailsPageState createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  String? docId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? reservationDetails;

  @override
  void initState() {
    super.initState();
    // Parse the URL to get the docId
    final uri = Uri.base;
    docId = uri.queryParameters['docId'];
    print("Fetched docId: $docId");
    _fetchReservationDetails();
  }

  Future<void> _fetchReservationDetails() async {
    if (docId != null) {
      try {
        DocumentSnapshot doc = await _firestore.collection('users').doc(docId).get();
        print("Document exists: ${doc.exists}");

        if (doc.exists) {
          setState(() {
            reservationDetails = doc.data() as Map<String, dynamic>;
          });
        }
      } catch (error, stackTrace) {
        print("Error fetching reservation details: $error");
        print("Stack Trace: $stackTrace");
      }
    }
  }

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(height: 300,
        child: Scaffold(
          appBar: AppBar(title: Text("Reservation Details"),
          centerTitle: true,
          ),
          body: Center(
            child: reservationDetails != null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${reservationDetails!['productName']}",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 50,),
                Text("Date: ${now.month}월 ${now.day}일 ${now.hour}시 ${now.minute}분",
                  style: TextStyle(
                    fontSize: 25,fontWeight: FontWeight.bold,
                  ),),
                Text("Name: ${reservationDetails!['userName']}",
                  style: TextStyle(
                    fontSize: 20,
                  ),),
                Text("Location${reservationDetails!['lacation']}",
                  style: TextStyle(
                    fontSize: 20,
                ),


                // 다른 필드들에 대한 정보도 추가할 수 있습니다.
              ],
            )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
