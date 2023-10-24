import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hanstour/tab_content.dart';
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
  late Position _currentPosition;
  String _locationMessage = "위치를 불러오는 중...";

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
          _locationMessage = "위치 서비스가 활성화되어 있지 않습니다.";
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationMessage = "위치 권한이 거부되었습니다.";
          });
          return;
        }
      }

      _currentPosition = await Geolocator.getCurrentPosition();
      setState(() {
        _locationMessage =
        "위도: ${_currentPosition.latitude}, 경도: ${_currentPosition.longitude}";
      });
    } catch (e) {
      setState(() {
        _locationMessage = "위치를 가져오는 중 오류가 발생했습니다: $e";
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

  // ... [다른 부분은 동일하게 유지]

  final Map<int, List<Widget>> _navRailToTabContents = {
    0: [ // Tour
      TabContent(),
      Center(child: Text('Tour - MOST PLAYED Content')),
      Center(child: Text('Tour - LOWEST PRICE Content'))
    ],
    1: [ // Activity
      Center(child: Text('Activity - TOP RATED Content')),
      Center(child: Text('Activity - MOST PLAYED Content')),
      Center(child: Text('Activity - LOWEST PRICE Content'))
    ],
    2: [ // Ticket
      Center(child: Text('Ticket - TOP RATED Content')),
      Center(child: Text('Location Content')),
      Center(child: Text('Ticket - LOWEST PRICE Content'))
    ],
    3: [ // Transport
      Center(child: Text('Transport - TOP RATED Content')),
      Center(child: Text('Transport - MOST PLAYED Content')),
      Center(child: Text('Transport - LOWEST PRICE Content'))
    ]
  };

  Widget _buildTabContent() {
    List<Widget> tabContents = _navRailToTabContents[_selectedIndex] ?? [
      Center(child: Text('Unknown index: $_selectedIndex')),
      Center(child: Text('Unknown index: $_selectedIndex')),
      Center(child: Text('Unknown index: $_selectedIndex'))
    ];
    if (_selectedIndex == 1) { // Activity의 경우
      tabContents[0] = Center(child: Text(_locationMessage));
    } else if (_selectedIndex == 2) { // Ticket의 경우
      tabContents[1] = Center(child: Text(_locationMessage));
    }


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
