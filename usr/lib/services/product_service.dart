import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductService extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Margherita Pizza',
      description: 'Classic pizza with tomato sauce, mozzarella, and basil',
      price: 12.99,
      imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400',
      category: 'Pizza',
      restaurantId: 'rest1',
    ),
    Product(
      id: '2',
      name: 'Cheeseburger',
      description: 'Juicy beef patty with cheese, lettuce, tomato, and pickles',
      price: 9.99,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      category: 'Burgers',
      restaurantId: 'rest1',
    ),
    Product(
      id: '3',
      name: 'Caesar Salad',
      description: 'Fresh romaine lettuce with Caesar dressing and croutons',
      price: 7.99,
      imageUrl: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400',
      category: 'Salads',
      restaurantId: 'rest1',
    ),
    Product(
      id: '4',
      name: 'Spaghetti Carbonara',
      description: 'Creamy pasta with bacon, eggs, and parmesan cheese',
      price: 14.99,
      imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=400',
      category: 'Pasta',
      restaurantId: 'rest1',
    ),
    Product(
      id: '5',
      name: 'Sushi Platter',
      description: 'Assorted fresh sushi rolls with wasabi and ginger',
      price: 18.99,
      imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
      category: 'Japanese',
      restaurantId: 'rest1',
    ),
    Product(
      id: '6',
      name: 'Chicken Tacos',
      description: 'Three soft tacos with grilled chicken and fresh toppings',
      price: 10.99,
      imageUrl: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=400',
      category: 'Mexican',
      restaurantId: 'rest1',
    ),
  ];

  List<Product> get products => List.unmodifiable(_products);

  List<String> get categories {
    return _products.map((p) => p.category).toSet().toList()..sort();
  }

  List<Product> getProductsByCategory(String category) {
    return _products.where((p) => p.category == category && p.isAvailable).toList();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    _products.removeWhere((p) => p.id == productId);
    notifyListeners();
  }

  void toggleProductAvailability(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index >= 0) {
      _products[index] = _products[index].copyWith(
        isAvailable: !_products[index].isAvailable,
      );
      notifyListeners();
    }
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}