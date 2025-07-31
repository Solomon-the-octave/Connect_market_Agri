import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/product_card.dart';
import 'widgets/bottom_nav_bar.dart'; 
import 'cart_manager.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _showPaymentMethodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Payment Method',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E2D),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose your preferred payment method:',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A5A4B),
                ),
              ),
              const SizedBox(height: 20),
              
              // Mobile Banking Option
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showMobileBankingOptions(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B9A7A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.phone_android, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Mobile Banking',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Visa Card Option
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showCardPaymentForm(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A365D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.credit_card, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Visa Card',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF8B9A7A),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMobileBankingOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Mobile Banking',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E2D),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select your mobile banking provider:',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A5A4B),
                ),
              ),
              const SizedBox(height: 20),
              
              // MTN Mobile Money
              _buildMobilePaymentOption(
                context,
                'MTN Mobile Money',
                'assets/images/mtn_logo.png',
                const Color(0xFFFFCC00),
                () => _processMobilePayment(context, 'MTN Mobile Money'),
              ),
              
              // Vodafone Cash
              _buildMobilePaymentOption(
                context,
                'Vodafone Cash',
                'assets/images/vodafone_logo.png',
                const Color(0xFFE60000),
                () => _processMobilePayment(context, 'Vodafone Cash'),
              ),
              
              // AirtelTigo Money
              _buildMobilePaymentOption(
                context,
                'AirtelTigo Money',
                'assets/images/airteltigo_logo.png',
                const Color(0xFF00A651),
                () => _processMobilePayment(context, 'AirtelTigo Money'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Back',
                style: TextStyle(
                  color: Color(0xFF8B9A7A),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobilePaymentOption(
    BuildContext context,
    String title,
    String iconPath,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_android, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _processMobilePayment(BuildContext context, String provider) {
    Navigator.of(context).pop();
    final _phoneController = TextEditingController();
    final _pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            provider,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E2D),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Amount: GH₵${CartManager().getTotal().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B9A7A),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Phone Number Field
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '0241234567',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                
                // PIN Field
                TextField(
                  controller: _pinController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Money PIN',
                    hintText: 'Enter your PIN',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 4,
                ),
                const SizedBox(height: 16),
                
                const Text(
                  'Please enter your mobile money details to complete the payment.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4A5A4B),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_phoneController.text.trim().isEmpty || _pinController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                Navigator.of(context).pop();
                _processMobilePaymentWithDetails(
                  context, 
                  provider, 
                  _phoneController.text.trim(),
                  _pinController.text.trim(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B9A7A),
                foregroundColor: Colors.white,
              ),
              child: const Text('Pay Now'),
            ),
          ],
        );
      },
    );
  }

  void _processMobilePaymentWithDetails(
    BuildContext context, 
    String provider, 
    String phoneNumber, 
    String pin,
  ) async {
    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B9A7A)),
              ),
              const SizedBox(height: 16),
              Text(
                'Processing $provider payment...',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A5A4B),
                ),
              ),
            ],
          ),
        );
      },
    );

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Store payment method in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('payment_methods')
            .add({
          'type': 'mobile_money',
          'provider': provider,
          'phoneNumber': phoneNumber,
          'isDefault': false,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Create order record
        final cartItems = CartManager().cartItems;
        final total = CartManager().getTotal();
        
        await FirebaseFirestore.instance
            .collection('orders')
            .add({
          'userId': user.uid,
          'items': cartItems.map((item) => {
            'name': item['name'],
            'price': item['price'],
            'quantity': item['quantity'],
            'unit': item['unit'],
          }).toList(),
          'total': total,
          'paymentMethod': {
            'type': 'mobile_money',
            'provider': provider,
            'phoneNumber': phoneNumber,
          },
          'status': 'completed',
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Simulate payment processing delay
        await Future.delayed(const Duration(seconds: 2));
        
        Navigator.of(context).pop(); // Close processing dialog
        _showPaymentSuccess(context, provider);
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close processing dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showCardPaymentForm(BuildContext context) {
    final _cardNumberController = TextEditingController();
    final _expiryController = TextEditingController();
    final _cvvController = TextEditingController();
    final _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Visa Card Payment',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E2D),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total: GH₵${CartManager().getTotal().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B9A7A),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Card Number
                TextField(
                  controller: _cardNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                    hintText: '1234 5678 9012 3456',
                    prefixIcon: Icon(Icons.credit_card),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                
                // Cardholder Name
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Cardholder Name',
                    hintText: 'John Doe',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    // Expiry Date
                    Expanded(
                      child: TextField(
                        controller: _expiryController,
                        decoration: const InputDecoration(
                          labelText: 'Expiry',
                          hintText: 'MM/YY',
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // CVV
                    Expanded(
                      child: TextField(
                        controller: _cvvController,
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                          hintText: '123',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_cardNumberController.text.trim().isEmpty ||
                    _nameController.text.trim().isEmpty ||
                    _expiryController.text.trim().isEmpty ||
                    _cvvController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all card details'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                Navigator.of(context).pop();
                _processCardPaymentWithDetails(
                  context,
                  _cardNumberController.text.trim(),
                  _nameController.text.trim(),
                  _expiryController.text.trim(),
                  _cvvController.text.trim(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A365D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Pay Now'),
            ),
          ],
        );
      },
    );
  }

  void _processCardPaymentWithDetails(
    BuildContext context,
    String cardNumber,
    String cardholderName,
    String expiryDate,
    String cvv,
  ) async {
    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A365D)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Processing card payment...',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A5A4B),
                ),
              ),
            ],
          ),
        );
      },
    );

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Store payment method in Firestore (mask card number for security)
        final maskedCardNumber = '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
        
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('payment_methods')
            .add({
          'type': 'visa_card',
          'cardholderName': cardholderName,
          'maskedCardNumber': maskedCardNumber,
          'expiryDate': expiryDate,
          'isDefault': false,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Create order record
        final cartItems = CartManager().cartItems;
        final total = CartManager().getTotal();
        
        await FirebaseFirestore.instance
            .collection('orders')
            .add({
          'userId': user.uid,
          'items': cartItems.map((item) => {
            'name': item['name'],
            'price': item['price'],
            'quantity': item['quantity'],
            'unit': item['unit'],
          }).toList(),
          'total': total,
          'paymentMethod': {
            'type': 'visa_card',
            'cardholderName': cardholderName,
            'maskedCardNumber': maskedCardNumber,
          },
          'status': 'completed',
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Simulate payment processing delay
        await Future.delayed(const Duration(seconds: 3));
        
        Navigator.of(context).pop(); // Close processing dialog
        _showPaymentSuccess(context, 'Visa Card');
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close processing dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showPaymentSuccess(BuildContext context, String paymentMethod) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Payment Successful!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E2D),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Amount: GH₵${CartManager().getTotal().toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B9A7A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Payment Method: $paymentMethod',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A5A4B),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your order has been placed successfully. Payment details have been saved securely. You will receive a confirmation shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A5A4B),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                CartManager().clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order placed successfully! Payment details saved.'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B9A7A),
                foregroundColor: Colors.white,
              ),
              child: const Text('Continue Shopping'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8C5A8),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Cart',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Builder(
                builder: (context) {
                  final cartItems = CartManager().cartItems;
                  if (cartItems.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 2,
                            child: ListTile(
                              leading: item['image'] != null
                                  ? Image.asset(
                                      item['image'],
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.shopping_bag),
                              title: Text(item['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Unit price: \$${item['unitPrice'].toStringAsFixed(2)} per ${item['unit']}', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                                  Text('Quantity: ${item['quantity']} ${item['unit']}', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                                  Text('Subtotal: \$${item['subtotal'].toStringAsFixed(2)}', style: TextStyle(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(
                            '\$${CartManager().getTotal().toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _showPaymentMethodDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B9A7A),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
