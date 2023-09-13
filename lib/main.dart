import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanstour/navigationrail_custom.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const NavigationRailExampleApp());
}

class NavigationRailExampleApp extends StatelessWidget {
  const NavigationRailExampleApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavRailExample(),
    );
  }
}

class NavRailExample extends StatefulWidget {
  const NavRailExample({Key? key}) : super(key: key);

  @override
  State<NavRailExample> createState() => _NavRailExampleState();
}

class _NavRailExampleState extends State<NavRailExample> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            minWidth: 119,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            leading: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(220, 80),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              onPressed: () {
                // Add your onPressed code here!
              },
              child: Image.asset(
                'assets/nomadMateLogo.png', // Replace with your image path
                fit: BoxFit.fill,
              ),
            ),
            destinations: <NavigationRailDestination>[
              buildCustomNavigationRailDestination1(
                icon: Icons.airplanemode_active,
                label: 'Tour',
              ),
              buildCustomNavigationRailDestination2(
                icon: Icons.paragliding,
                label: 'Activity',
              ),
              buildCustomNavigationRailDestination3(
                icon: Icons.route,
                label: 'Transport',
              ),
              buildCustomNavigationRailDestination4(
                icon: Icons.airplane_ticket,
                label: 'Ticket',
              ),
              buildCustomNavigationRailDestination5(
                icon: Icons.hotel,
                label: 'Hotel',
              ),
            ],
          ),
          const VerticalDivider(thickness: 3, width: 1),
          Expanded(
            child: DefaultTabController(
              length: 3, // 탭의 수
              child: Column(
                children: [
                  TabBar(

                    indicatorSize: TabBarIndicatorSize.tab,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 60,
                    ),
                    indicator: BoxDecoration(
                      color: Colors.blue,
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
                  Expanded(
                    child: TabBarView(
                      children: [
                        // 각 탭의 내용을 여기에 추가
                        Center(child: Text('Tab 1 Content')),
                        Center(child: Text('Tab 2 Content')),
                        Center(child: Text('Tab 3 Content')),
                      ],
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
