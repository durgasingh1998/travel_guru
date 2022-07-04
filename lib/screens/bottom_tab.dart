import 'package:flutter/material.dart';
import 'package:travel_guru/widgets/sign_in.dart';
import 'package:travel_guru/widgets/sign_up.dart';

class BottomTabScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/bottom_tab';
  const BottomTabScreen({Key? key}) : super(key: key);

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  int _tabNo = 0;
  final tabOption = const [
    SignInScreen(),
    SignUpScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: tabOption[_tabNo],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'SignIn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'SignUp',
          ),
        ],
        onTap: (selected) {
          setState(() {
            _tabNo = selected;
          });
        },
        currentIndex: _tabNo,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }
}
