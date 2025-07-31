import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Widget accountTile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF7A8471)),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showDeliveryAddressDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController(text: 'Kigali, Rwanda');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delivery Address'),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(labelText: 'Address'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Save updated address logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Address updated')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodsDialog(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Methods'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('payment_methods')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading payment methods'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No payment methods available'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final type = data['type'] ?? '';
                    final title = type == 'mobile_money'
                        ? data['provider'] ?? 'Mobile Money'
                        : data['maskedCardNumber'] ?? 'Card';
                    final subtitle = type == 'mobile_money'
                        ? data['phoneNumber'] ?? ''
                        : data['cardHolder'] ?? '';
                    final icon = type == 'mobile_money' ? Icons.phone_android : Icons.credit_card;

                    return ListTile(
                      leading: Icon(icon),
                      title: Text(title),
                      subtitle: Text(subtitle),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          doc.reference.delete();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
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
      builder: (_) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Text(
            'For assistance, contact support@example.com or visit our FAQ page in the app.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFB8C5A8), 
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: const Color(0xFF7A8471),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFFB8C5A8),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              user?.email ?? 'Guest',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 16),
          accountTile(Icons.shopping_bag, 'Orders', () {
            Navigator.pushNamed(context, '/orders');
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
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
