import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/user_avatar.png'),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Gloria Doe',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(height: 24),
          accountTile(Icons.shopping_bag, 'Orders'),
          accountTile(Icons.location_on, 'Delivery Address'),
          accountTile(Icons.credit_card, 'Payment Methods'),
          accountTile(Icons.favorite, 'Favourites'),
          accountTile(Icons.settings, 'Settings'),
          accountTile(Icons.help_outline, 'Help & Support'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget accountTile(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.green),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        const Divider(),
      ],
    );
  }
}
