import 'package:flutter/material.dart';
import 'screens/customer/customer_home_screen.dart';
import 'screens/restaurant/restaurant_home_screen.dart';
import 'screens/role_selection_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RoleSelectionScreen(),
        '/customer': (context) => const CustomerHomeScreen(),
        '/restaurant': (context) => const RestaurantHomeScreen(),
      },
    );
  }
}