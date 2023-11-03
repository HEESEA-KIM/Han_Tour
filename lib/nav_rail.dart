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
import 'nav_rail_destinations.dart';

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
        setState(() {
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
          });
          return;
        }
      }

      _currentPosition = await Geolocator.getCurrentPosition();
      setState(() {
      });
    } catch (e) {
      setState(() {
      });
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
    0: [ // Tour
      TabContent(),
      TicketMostContent(),
      TicketRowestContent(),
    ],
    1: [ // Activity
      ActivityTopContent(),
      ActivityMostContent(),
      ActivityRowestContent(),
    ],
    2: [ // Ticket
      TourTopContent(),
      TourMostContent(),
      TourRowestContent(),
    ],
  };

  Widget _buildTabContent() {
    if(_currentPosition == null){
      return Center(child: CircularProgressIndicator());
    }
    // 초기화된 위치 정보를 바탕으로 TabContent를 빌드
    List<Widget> tabContents = _navRailToTabContents[_selectedIndex] ?? [
      Center(child: Text('Unknown index: $_selectedIndex')),
      Center(child: Text('Unknown index: $_selectedIndex')),
      Center(child: Text('Unknown index: $_selectedIndex'))
    ];



    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
            child: _buildTabBar(),
          ),
          Expanded(
            child: TabBarView(children: tabContents),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ['TOP RATED', 'MOST PLAYED', 'LOWEST PRICE'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3))
        ],
      ),
      child: TabBar(
        onTap: (index) {},
        indicator: ShapeDecoration(
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        unselectedLabelColor: Colors.black26,
        labelColor: Colors.white,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      ),
    );
  }
}
