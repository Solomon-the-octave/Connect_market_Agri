import 'package:flutter/material.dart';
import 'cart_manager.dart';
import 'widgets/quantity_selector.dart';

const primaryGreen = Color(0xFF7A8471);
const lightGreen = Color(0xFFB8C5A8);
const darkGreen = Color(0xFF5A6B4F);
const accentOrange = Color(0xFFE67E22);
const backgroundColor = Color(0xFFB8C5A8);

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String searchQuery = '';
  final List<Map<String, String>> exclusiveProducts = [
    {'name': 'Red Apple', 'price': '4.99', 'image': 'assets/images/apple.png', 'unit': 'kg'},
    {'name': 'Banana', 'price': '2.99', 'image': 'assets/images/banana.png', 'unit': 'kg'},
    {'name': 'Bell Pepper', 'price': '3.49', 'image': 'assets/images/bell_peppers.png', 'unit': 'kg'},
    {'name': 'Ginger', 'price': '1.99', 'image': 'assets/images/ginger.jpeg', 'unit': 'kg'},
  ];
  
  final List<Map<String, String>> bestSellingProducts = [
    {'name': 'Yam Flour', 'price': '10.50', 'image': 'assets/images/yam_flour.png', 'unit': 'kg'},
    {'name': 'Fresh Carrots', 'price': '2.50', 'image': 'assets/images/carrots.png', 'unit': 'kg'},
    {'name': 'Oranges', 'price': '3.99', 'image': 'assets/images/oranges.png', 'unit': 'kg'},
    {'name': 'Groundnuts', 'price': '6.00', 'image': 'assets/images/groundnuts.png', 'unit': 'kg'},
    {'name': 'Onions', 'price': '7.00', 'image': 'assets/images/onions.png', 'unit': 'kg'},
    {'name': 'Peas', 'price': '9.00', 'image': 'assets/images/peas.png', 'unit': 'kg'},
  ];

  @override
  Widget build(BuildContext context) {
    final allProducts = [...exclusiveProducts, ...bestSellingProducts];
    final filteredProducts = searchQuery.isNotEmpty
        ? allProducts.where((p) => p['name']!.toLowerCase().contains(searchQuery.toLowerCase())).toList()
        : null;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: darkGreen, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    'Dhaka, Banasree',
                    style: TextStyle(
                      color: darkGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: primaryGreen,
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.trim();
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: darkGreen.withOpacity(0.6)),
                  hintText: 'Search Store',
                  hintStyle: TextStyle(color: darkGreen.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: filteredProducts != null
                    ? _buildSearchResults(filteredProducts)
                    : _buildDefaultContent(),
              ),
            ),

            // Bottom Navigation
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Shop', true, context),
                  _buildNavItem(Icons.search, 'Explore', false, context),
                  _buildNavItem(Icons.shopping_cart, 'Cart', false, context),
                  _buildNavItem(Icons.favorite, 'Favourite', false, context),
                  _buildNavItem(Icons.person, 'Account', false, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<Map<String, String>> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _ProductGridItem(product: products[index]);
      },
    );
  }

  Widget _buildDefaultContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Exclusive Offer Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Exclusive Offer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            Text(
              'See all',
              style: TextStyle(
                color: primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Horizontal Product List
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: exclusiveProducts.length,
            itemBuilder: (context, index) {
              return _HorizontalProductItem(product: exclusiveProducts[index]);
            },
          ),
        ),
        const SizedBox(height: 32),

        // Best Selling Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Best Selling',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            Text(
              'See all',
              style: TextStyle(
                color: primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Grid of Products
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
          ),
          itemCount: bestSellingProducts.length,
          itemBuilder: (context, index) {
            return _ProductGridItem(product: bestSellingProducts[index]);
          },
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (label) {
          case 'Explore':
            Navigator.pushNamed(context, '/explore');
            break;
          case 'Cart':
            Navigator.pushNamed(context, '/cart');
            break;
          case 'Favourite':
            Navigator.pushNamed(context, '/favourites');
            break;
          case 'Account':
            Navigator.pushNamed(context, '/account');
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? primaryGreen : darkGreen.withOpacity(0.5),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? primaryGreen : darkGreen.withOpacity(0.5),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _HorizontalProductItem extends StatefulWidget {
  final Map<String, String> product;

  const _HorizontalProductItem({required this.product});

  @override
  State<_HorizontalProductItem> createState() => _HorizontalProductItemState();
}

class _HorizontalProductItemState extends State<_HorizontalProductItem> {
  int quantity = 1;
  late double unitPrice;
  late String unit;

  @override
  void initState() {
    super.initState();
    unitPrice = double.tryParse(widget.product['price']!) ?? 0.0;
    unit = widget.product['unit'] ?? 'kg';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: lightGreen.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Image.asset(
              widget.product['image']!,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product['name']!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$quantity $unit, Price: \$${(unitPrice * quantity).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 10,
                    color: darkGreen.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuantitySelector(
                      quantity: quantity,
                      unit: unit,
                      onIncrement: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      onDecrement: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      small: true,
                    ),
                    SizedBox(
                      height: 24,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                          minimumSize: const Size(30, 24),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          CartManager().addToCart(widget.product, quantity, unit, unitPrice);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${widget.product['name']} ($quantity $unit) added to cart!')),
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.add_shopping_cart, size: 12),
                            SizedBox(width: 2),
                            Text('Add', style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductGridItem extends StatelessWidget {
  final Map<String, String> product;

  const _ProductGridItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: lightGreen.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Image.asset(
                product['image']!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name']!,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${product['unit']}, Price: \$${product['price']}',
                  style: TextStyle(
                    fontSize: 11,
                    color: darkGreen.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}