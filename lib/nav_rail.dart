import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hanstour/tab_content.dart';
import 'package:hanstour/tab_content_Ticket_most.dart';
import 'package:hanstour/tab_content_Ticket_rowest.dart';
import 'package:hanstour/tab_content_Tour_most.dart';
import 'package:hanstour/tab_content_Tour_rowest.dart';
import 'package:hanstour/tab_content_Tour_top.dart';
import 'package:hanstour/tab_content_activity_most.dart';
import 'package:hanstour/tab_content_activity_rowest.dart';
import 'package:hanstour/tab_content_activity_top.dart';
import 'package:hanstour/nav_rail_destinations.dart';

class NavigationRailApp extends StatelessWidget {
  const NavigationRailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavRail(),
    );
  }
}

class NavRail extends StatefulWidget {
  const NavRail({super.key});

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  int _selectedIndex = 0;
  bool _extended = true;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {});
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {});
          return;
        }
      }

      _currentPosition = await Geolocator.getCurrentPosition();
      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Row(
          children: [
            Stack(
              children: [
                NavigationRail(
                  //접고 펼치기
                  minWidth: _extended ? 121 : 40,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) =>
                      setState(() => _selectedIndex = index),
                  leading: _buildLeading(),
                  destinations: buildNavRailDestinations(_extended),
                ),
                Positioned(
                  top: 150.0 + (_selectedIndex * 120.0),
                  left: _extended ? 265 : 0,
                  child: Container(
                    height: 56.0,
                    width: 3,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Expanded(child: _buildTabContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading() {
    //로고있는 부분
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_extended)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(220, 80),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            onPressed: () {},
            child: Image.asset(
              'assets/nomadMateLogo.png',
              fit: BoxFit.fill,
            ),
          ),
        IconButton(
          icon: Icon(
            _extended ? Icons.arrow_circle_left : Icons.arrow_circle_right,
            color: Colors.blue,
          ),
          onPressed: () => setState(() => _extended = !_extended),
        ),
      ],
    );
  }
  final Map<int, List<Widget>> _navRailToTabContents = {
    0: [
      // Tour
      TabContent(),
      TicketMostContent(),
      TicketRowestContent(),
    ],
    1: [
      // Activity
      ActivityTopContent(),
      ActivityMostContent(),
      ActivityRowestContent(),
    ],
    2: [
      // Ticket
      TourTopContent(),
      TourMostContent(),
      TourRowestContent(),
    ],
  };

  Widget _buildTabContent() {
    if (_currentPosition == null) {
      return Center(child: CircularProgressIndicator());
    }
// 선택된 인덱스에 따라 탭 내용을 결정
    List<Widget> tabContents = _navRailToTabContents[_selectedIndex] ??
        [
          Center(child: Text('Unknown index: $_selectedIndex')),
          Center(child: Text('Unknown index: $_selectedIndex')),
          Center(child: Text('Unknown index: $_selectedIndex')),
        ];

    // TabBarView를 DefaultTabController로 감싸서 제공
    return DefaultTabController(
      length: tabContents.length, // 탭의 수를 제공해야 함
      child: Column(
        children: [
          SizedBox(height: 140,),
          // 여기서는 TabBar 위젯이 없으므로 TabBarView만 진행
          Expanded(
            child: TabBarView(children: tabContents),
          ),
        ],
      ),
    );
  }
}
