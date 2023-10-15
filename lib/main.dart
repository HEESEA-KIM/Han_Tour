import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hanstour/navigationrail_custom.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(NavigationRailExampleApp());
}

class NavigationRailExampleApp extends StatelessWidget {
  const NavigationRailExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavRailExample(),
    );
  }
}

class NavRailExample extends StatefulWidget {
  const NavRailExample({super.key});

  @override
  State<NavRailExample> createState() => _NavRailExampleState();
}

class _NavRailExampleState extends State<NavRailExample> {
  int _selectedIndex = 0;
  bool _extended = true;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  List<NavigationRailDestination> get _navRailDestinations {
    final icons = [
      Icons.airplanemode_active,
      Icons.paragliding,
      Icons.route,
      Icons.airplane_ticket,
      Icons.hotel
    ];
    final labels = ["Tour", "Activity", "Transport", "Ticket", "Hotel"];
    return List.generate(icons.length, (index) {
      return buildCustomNavigationRailDestination(
        icon: icons[index],
        isExtended: _extended,
        label: labels[index],
      );
    });
  }

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
    return Scaffold(
      body: Row(
        children: [
          Stack(
            children: [
              NavigationRail(
                minWidth: _extended ? 121 : 40,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) =>
                    setState(() => _selectedIndex = index),
                leading: _buildLeading(),
                destinations: _navRailDestinations,
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
    );
  }

  Widget _buildLeading() {
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

  Widget _buildTabContent() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
            child: _buildTabBar(),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: _buildTabBarView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ['RECOMMENDED', 'TOP RATED', 'LOWEST PRICE'];
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
        onTap: (index) {
          _analytics.logEvent(
            name: 'tab_changed',
            parameters: <String, dynamic>{
              'tab_index': index,
              'tab_name': tabs[index],
            },
          );
        },
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: ShapeDecoration(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0))),
        unselectedLabelColor: Colors.black26,
        labelColor: Colors.white,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        indicatorColor: Colors.blue,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      children: [
        Center(child: Text(_locationMessage)),
        Center(child: Text('Tab 2 Content')),
        Center(child: Text('Tab 3 Content')),
      ],
    );
  }
}
