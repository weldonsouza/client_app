import 'package:flutter/material.dart';
import 'package:client_app/src/app/pages/address/address_view.dart';
import 'package:client_app/src/app/pages/home/home_view.dart';
import 'package:client_app/src/core/utils/constants.dart';

import '../my_requests/my_requests_view.dart';

class BottomNavigationBarController extends StatefulWidget {
  const BottomNavigationBarController({Key? key}) : super(key: key);

  static String get routeName => '/bottom_navigation';

  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomeView(),
    const MyRequestsView(),
    const MyRequestsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.surface2,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Constants.blackColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedIconTheme: const IconThemeData(color: Constants.blackColor),
        selectedIconTheme: const IconThemeData(color: Constants.primaryColor),
        unselectedItemColor: Constants.blackColor,
        iconSize: 18,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Serviços',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Meus pedidos',
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
