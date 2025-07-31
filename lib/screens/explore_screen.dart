import 'package:flutter/material.dart';
import 'widgets/product_card.dart';
import 'widgets/bottom_nav_bar.dart';
import 'category_screen.dart';
import '../data/category_data.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8C5A8),
      bottomNavigationBar: BottomNavBar(currentIndex: 1), 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore Categories',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Category',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12, 
                mainAxisSpacing: 12,
                childAspectRatio: 3, 
                children: [
                  _buildCategoryCard(
                    context,
                    'assets/images/vegetables.png',
                    'Vegetables',
                    '${CategoryData.getItemsForCategory('Vegetables').length} items',
                  ),
                  _buildCategoryCard(
                    context,
                    'assets/images/fruits.png',
                    'Fruits',
                    '${CategoryData.getItemsForCategory('Fruits').length} items',
                  ),
                  _buildCategoryCard(
                    context,
                    'assets/images/beverages.png',
                    'Beverages',
                    '${CategoryData.getItemsForCategory('Beverages').length} items',
                  ),
                  _buildCategoryCard(
                    context,
                    'assets/images/flour.png',
                    'Flour',
                    '${CategoryData.getItemsForCategory('Flour').length} items',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String imagePath,
    String title,
    String itemCount,
  ) {
    return GestureDetector(
      onTap: () {
        final items = CategoryData.getItemsForCategory(title);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              categoryName: title,
              items: items,
            ),
          ),
        );
      },
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8C5A8).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Color(0xFF8B9A7A),
                        size: 24,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E2D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      itemCount,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A5A4B),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF8B9A7A),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
