import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'widgets/bottom_nav_bar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFB8C5A8),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
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
          Center(
            child: Column(
              children: [
                Text(
                  user?.displayName ?? 'User',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 6),
                Text(
                  user?.email ?? '',
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          accountTile(Icons.shopping_bag, 'Orders', () {
            _showOrdersDialog(context);
          }),
          accountTile(Icons.location_on, 'Delivery Address', () {
            _showDeliveryAddressDialog(context);
          }),
          accountTile(Icons.credit_card, 'Payment Methods', () {
            _showPaymentMethodsDialog(context);
          }),
          accountTile(Icons.favorite, 'Favourites', () {
            Navigator.pushNamed(context, '/favourites');
          }),
          accountTile(Icons.settings, 'Settings', () {
            Navigator.pushNamed(context, '/settings');
          }),
          accountTile(Icons.help_outline, 'Help & Support', () {
            _showHelpSupportDialog(context);
          }),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // Optionally: Navigate to login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
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

  Widget accountTile(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.green),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }

  void _showOrdersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('My Orders'),
          content: const SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.shopping_bag, color: Colors.green),
                  title: Text('Order #1234'),
                  subtitle: Text('Delivered - 2 items'),
                  trailing: Text('\$25.50'),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_bag, color: Colors.orange),
                  title: Text('Order #1235'),
                  subtitle: Text('In Transit - 3 items'),
                  trailing: Text('\$42.00'),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_bag, color: Colors.blue),
                  title: Text('Order #1236'),
                  subtitle: Text('Processing - 1 item'),
                  trailing: Text('\$15.75'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showDeliveryAddressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delivery Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Address:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('123 Main Street\nDhaka, Banasree\nBangladesh'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showEditAddressDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Edit Address', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showEditAddressDialog(BuildContext context) {
    final TextEditingController addressController = TextEditingController(
      text: '123 Main Street\nDhaka, Banasree\nBangladesh',
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Address'),
          content: TextField(
            controller: addressController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Enter your delivery address',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Address updated successfully!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentMethodsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Methods'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.blue),
                title: const Text('**** **** **** 1234'),
                subtitle: const Text('Visa - Default'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment method removed!'),
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: Colors.green),
                title: const Text('Mobile Banking'),
                subtitle: const Text('bKash - +880 1234567890'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment method removed!'),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add new payment method feature coming soon!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Add New Method', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Help & Support'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text('Call Support'),
                subtitle: const Text('+880 1234-567890'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Calling support...'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.email, color: Colors.blue),
                title: const Text('Email Support'),
                subtitle: const Text('support@marketconnect.com'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening email client...'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat, color: Colors.orange),
                title: const Text('Live Chat'),
                subtitle: const Text('Chat with our support team'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Starting live chat...'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.purple),
                title: const Text('FAQ'),
                subtitle: const Text('Frequently asked questions'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening FAQ section...'),
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
