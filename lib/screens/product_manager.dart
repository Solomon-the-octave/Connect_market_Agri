import 'dart:io';

class ProductManager {
  static final ProductManager _instance = ProductManager._internal();
  factory ProductManager() => _instance;
  ProductManager._internal();

  final List<Map<String, dynamic>> _products = [
    // Initial static products for buyers
    {
      'name': 'Red Apple',
      'price': '\u00024.99',
      'image': 'assets/images/apple.png',
      'isFarmer': true,
      'description': 'Fresh and crispy red apples.',
      'category': 'Fruits',
      'status': 'sold',
      'unit': 'kgs',
      'quantity': '30',
    },
    {
      'name': 'Banana',
      'price': '\u00022.99',
      'image': 'assets/images/banana.png',
      'isFarmer': true,
      'description': 'Sweet organic bananas, farm fresh.',
      'category': 'Fruits',
      'status': 'sold',
      'unit': 'kgs',
      'quantity': '50',
    },
    {
      'name': 'Banana',
      'price': '\u00022.99',
      'image': 'assets/images/banana.png',
      'isFarmer': true,
      'description': 'Bananas available for immediate order.',
      'category': 'Fruits',
      'status': 'available',
      'unit': 'kgs',
      'quantity': '20',
    },
    {
      'name': 'Maize',
      'price': '\u00023.50',
      'image': 'assets/images/maize.png',
      'isFarmer': true,
      'description': 'High-quality maize, freshly harvested.',
      'category': 'Grains',
      'status': 'sold',
      'unit': 'bags',
      'quantity': '10',
    },
    {
      'name': 'Tomato',
      'price': '\u00021.80',
      'image': 'assets/images/tomato.png',
      'isFarmer': true,
      'description': 'Organic tomatoes, juicy and ripe.',
      'category': 'Vegetables',
      'status': 'available',
      'unit': 'kgs',
      'quantity': '40',
    },
    // ... add more initial products if needed
  ];

  List<Map<String, dynamic>> get products => _products;

  void addProduct(Map<String, dynamic> product) {
    _products.insert(0, product);
  }
}
