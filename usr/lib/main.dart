import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/restaurant_admin_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/customer/customer_home_screen.dart';
import 'screens/restaurant/restaurant_home_screen.dart';

void main() {
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RoleSelectionScreen(),
        '/customer': (context) => const CustomerHomeScreen(),
        '/restaurant': (context) => const RestaurantHomeScreen(),
        '/cart': (context) => const CartScreen(),
        '/admin': (context) => const RestaurantAdminScreen(),
      },
    );
  }
}
