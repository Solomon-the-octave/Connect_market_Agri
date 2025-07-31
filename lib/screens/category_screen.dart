import 'package:flutter/material.dart';
import 'widgets/product_card.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/quantity_selector.dart';
import 'cart_manager.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  final List<Map<String, dynamic>> items;

  const CategoryScreen({
    super.key,
    required this.categoryName,
    required this.items,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CartManager _cartManager = CartManager();
  Map<String, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    // Initialize quantities for all items
    for (var item in widget.items) {
      _quantities[item['name']] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB8C5A8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B9A7A),
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.categoryName} (${widget.items.length} items)',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E2D),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    final itemName = item['name'];
                    final currentQuantity = _quantities[itemName] ?? 0;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item['imagePath'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB8C5A8).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Color(0xFF8B9A7A),
                                ),
                              );
                            },
                          ),
                        ),
                        title: Text(
                          item['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2C3E2D),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              item['description'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4A5A4B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'GH₵${item['price']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF8B9A7A),
                                  ),
                                ),
                                Text(
                                  '${item['unit']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4A5A4B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: currentQuantity == 0
                            ? Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B9A7A),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.add, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      _quantities[itemName] = 1;
                                    });
                                    // Create item with correct image field for cart
                                    final cartItem = Map<String, dynamic>.from(item);
                                    cartItem['image'] = item['imagePath'];
                                    _cartManager.addToCart(
                                      cartItem,
                                      1,
                                      item['unit'],
                                      double.parse(item['price']),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${item['name']} added to cart'),
                                        backgroundColor: const Color(0xFF8B9A7A),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : QuantitySelector(
                                quantity: currentQuantity,
                                unit: item['unit'].replaceAll('per ', ''),
                                small: true,
                                onIncrement: () {
                                  setState(() {
                                    _quantities[itemName] = currentQuantity + 1;
                                  });
                                  // Create item with correct image field for cart
                                  final cartItem = Map<String, dynamic>.from(item);
                                  cartItem['image'] = item['imagePath'];
                                  _cartManager.updateQuantity(
                                    cartItem,
                                    currentQuantity + 1,
                                    item['unit'],
                                    double.parse(item['price']),
                                  );
                                },
                                onDecrement: () {
                                  if (currentQuantity > 1) {
                                    setState(() {
                                      _quantities[itemName] = currentQuantity - 1;
                                    });
                                    // Create item with correct image field for cart
                                    final cartItem = Map<String, dynamic>.from(item);
                                    cartItem['image'] = item['imagePath'];
                                    _cartManager.updateQuantity(
                                      cartItem,
                                      currentQuantity - 1,
                                      item['unit'],
                                      double.parse(item['price']),
                                    );
                                  } else {
                                    setState(() {
                                      _quantities[itemName] = 0;
                                    });
                                    // Create item with correct image field for cart
                                    final cartItem = Map<String, dynamic>.from(item);
                                    cartItem['image'] = item['imagePath'];
                                    _cartManager.removeFromCart(cartItem, item['unit']);
                                  }
                                },
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
