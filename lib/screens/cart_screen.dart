import 'package:flutter/material.dart';
import 'widgets/product_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                childAspectRatio: 0.75,
                children: [
                  ProductCard(
                    imagePath: 'assets/images/vegetables.png',
                    title: 'Vegetables',
                    weight: '120 items',
                    price: '',
                  ),
                  ProductCard(
                    imagePath: 'assets/images/fruits.png',
                    title: 'Fruits',
                    weight: '96 items',
                    price: '',
                  ),
                  ProductCard(
                    imagePath: 'assets/images/beverages.png',
                    title: 'Beverages',
                    weight: '58 items',
                    price: '',
                  ),
                  ProductCard(
                    imagePath: 'assets/images/bakery.png',
                    title: 'Bakery',
                    weight: '72 items',
                    price: '',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
