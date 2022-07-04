import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/DashboardScreen';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TravelGuru')),
    );
  }
}
