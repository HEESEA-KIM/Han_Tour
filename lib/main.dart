import 'package:flutter/material.dart';
import 'package:hanstour/navigationrail_custom.dart';

void main() {
  runApp(const NavigationRailExampleApp());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Stack(
            children: [
              NavigationRail(
                minWidth: _extended ? 121 : 40,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                leading: Row(
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
                        _extended
                            ? Icons.arrow_circle_left
                            : Icons.arrow_circle_right,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          _extended = !_extended;
                        });
                      },
                    ),
                  ],
                ),
                destinations: <NavigationRailDestination>[
                  buildCustomNavigationRailDestination(
                    icon: Icons.airplanemode_active,
                    isExtended: _extended,
                    label: "Tour",
                  ),
                  buildCustomNavigationRailDestination(
                    icon: Icons.paragliding,
                    isExtended: _extended,
                    label: "Activity",
                  ),
                  buildCustomNavigationRailDestination(
                    icon: Icons.route,
                    isExtended: _extended,
                    label: "Transport",
                  ),
                  buildCustomNavigationRailDestination(
                    icon: Icons.airplane_ticket,
                    isExtended: _extended,
                    label: "Ticket",
                  ),
                  buildCustomNavigationRailDestination(
                    icon: Icons.hotel,
                    isExtended: _extended,
                    label: "Hotel",
                  ),
                ],
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
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 60,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: ShapeDecoration(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        unselectedLabelColor: Colors.black26,
                        labelColor: Colors.white,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        indicatorColor: Colors.blue,
                        tabs: [
                          Tab(text: 'RECOMMENDED'),
                          Tab(text: 'TOP RATED'),
                          Tab(text: 'LOWEST PRICE'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      child: TabBarView(
                        children: [
                          Center(child: Text('Tab 1 Content')),
                          Center(child: Text('Tab 2 Content')),
                          Center(child: Text('Tab 3 Content')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
