class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => List.unmodifiable(_cartItems);

  void addToCart(Map<String, dynamic> product, int quantity, String unit, double unitPrice) {
    final existingIndex = _cartItems.indexWhere((item) =>
      item['name'] == product['name'] && item['unit'] == unit);
    if (existingIndex != -1) {
      _cartItems[existingIndex]['quantity'] += quantity;
      _cartItems[existingIndex]['subtotal'] = _cartItems[existingIndex]['quantity'] * unitPrice;
    } else {
      _cartItems.add({
        ...product,
        'quantity': quantity,
        'unit': unit,
        'unitPrice': unitPrice,
        'subtotal': quantity * unitPrice,
      });
    }
  }

  void updateQuantity(Map<String, dynamic> product, int quantity, String unit, double unitPrice) {
    final existingIndex = _cartItems.indexWhere((item) =>
      item['name'] == product['name'] && item['unit'] == unit);
    if (existingIndex != -1) {
      _cartItems[existingIndex]['quantity'] = quantity;
      _cartItems[existingIndex]['subtotal'] = quantity * unitPrice;
    }
  }

  void removeFromCart(Map<String, dynamic> product, String unit) {
    _cartItems.removeWhere((item) => item['name'] == product['name'] && item['unit'] == unit);
  }

  double getTotal() {
    return _cartItems.fold(0.0, (sum, item) => sum + (item['subtotal'] as double));
  }

  void clearCart() {
    _cartItems.clear();
  }
}
