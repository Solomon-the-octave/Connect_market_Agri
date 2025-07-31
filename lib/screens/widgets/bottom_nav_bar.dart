import 'package:flutter/material.dart';

// Define your color constants if not already defined elsewhere
const primaryGreen = Color(0xFF7A8471);
const darkGreen = Color(0xFF5A6B4F);

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _buildNavItem(Icons.storefront, 'Shop', currentIndex == 0, context, '/shop'),
          _buildNavItem(Icons.search, 'Explore', currentIndex == 1, context, '/explore'),
          _buildNavItem(Icons.shopping_cart, 'Cart', currentIndex == 2, context, '/cart'),
          _buildNavItem(Icons.favorite, 'Favourite', currentIndex == 3, context, '/favourites'),
          _buildNavItem(Icons.person, 'Account', currentIndex == 4, context, '/account'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, BuildContext context, String route) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          Navigator.pushReplacementNamed(context, route);
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