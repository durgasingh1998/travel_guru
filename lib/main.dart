import 'package:flutter/material.dart';
import 'package:travel_guru/screens/bottom_tab.dart';
import 'package:travel_guru/screens/dashboard.dart';
import 'package:travel_guru/widgets/sign_in.dart';
import 'package:travel_guru/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      title: 'Travel Guru',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == DashboardScreen.ROUTE_NAME) {
          return MaterialPageRoute(builder: (_) => DashboardScreen());
        } else if (settings.name == BottomTabScreen.ROUTE_NAME) {
          return MaterialPageRoute(
            builder: (_) => const BottomTabScreen(),
          );
        }

        return null;
      },
    );
  }
}
