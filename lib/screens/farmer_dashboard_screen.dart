import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'product_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FarmerDashboardScreen extends StatefulWidget {
  const FarmerDashboardScreen({super.key});

  @override
  State<FarmerDashboardScreen> createState() => _FarmerDashboardScreenState();
}

class _FarmerDashboardScreenState extends State<FarmerDashboardScreen> {
  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _price;
  String _unit = 'kgs';
  String? _quantity;
  String? _description;
  String? _category;
  File? _imageFile;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _addProduct() {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      _formKey.currentState!.save();
      ProductManager().addProduct({
        'name': _name!,
        'price': _price!,
        'unit': _unit,
        'quantity': _quantity!,
        'imageFile': _imageFile!,
        'isFarmer': true,
      });
      setState(() {
        _name = null;
        _price = null;
        _unit = 'kgs';
        _quantity = null;
        _imageFile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_selectedIndex == 0) {
      body = _buildDashboard();
    } else if (_selectedIndex == 1) {
      body = _buildMessagesUI();
    } else {
      body = _buildAccountUI();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFA8B5A0),
      body: SafeArea(child: body),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildDashboard() {
    final allProducts = ProductManager().products.where((p) => p['isFarmer'] == true).toList();
    final availableProducts = allProducts.where((p) => (p['status'] ?? 'available') == 'available').toList();
    final soldProducts = allProducts.where((p) => (p['status'] ?? '') == 'sold').toList();
    final orderedProducts = allProducts.where((p) => (p['status'] ?? '') == 'ordered').toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'My Products',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF5A6B4F)),
          ),
          const SizedBox(height: 4),
          Text(
            'Manage your current stock, see what you have sold, and track orders from buyers. Add new products to your market below.',
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _imageFile == null
                        ? const Icon(Icons.camera_alt, color: Colors.grey)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(_imageFile!, fit: BoxFit.cover),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Product Name'),
                        validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
                        onSaved: (v) => _name = v,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Description'),
                        validator: (v) => v == null || v.isEmpty ? 'Enter description' : null,
                        onSaved: (v) => _description = v,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Category'),
                        validator: (v) => v == null || v.isEmpty ? 'Enter category' : null,
                        onSaved: (v) => _category = v,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'Price per kg'),
                              keyboardType: TextInputType.number,
                              validator: (v) => v == null || v.isEmpty ? 'Enter price' : null,
                              onSaved: (v) => _price = v,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 70,
                            child: DropdownButtonFormField<String>(
                              value: _unit,
                              items: const [
                                DropdownMenuItem(value: 'kgs', child: Text('kgs')),
                                DropdownMenuItem(value: 'bags', child: Text('bags')),
                                DropdownMenuItem(value: 'litres', child: Text('litres')),
                              ],
                              onChanged: (v) {
                                if (v != null) setState(() => _unit = v);
                              },
                              decoration: const InputDecoration(labelText: 'Unit'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'Qty'),
                              keyboardType: TextInputType.number,
                              validator: (v) => v == null || v.isEmpty ? 'Qty' : null,
                              onSaved: (v) => _quantity = v,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.check, color: Color(0xFF7A8471)),
                  onPressed: _addProduct,
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Available Products
                  const Text(
                    'Available Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF7A8471)),
                  ),
                  const SizedBox(height: 8),
                  availableProducts.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('No available products. Add some!', style: TextStyle(color: Colors.grey)),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: availableProducts.length,
                          itemBuilder: (context, index) {
                            final product = availableProducts[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              color: const Color(0xFFD1E7DD),
                              child: ListTile(
                                leading: (product['image'] != null)
                                    ? Image.asset(product['image'], width: 50, height: 50, fit: BoxFit.cover)
                                    : (product['imageFile'] != null
                                        ? Image.file(product['imageFile'], width: 50, height: 50, fit: BoxFit.cover)
                                        : const Icon(Icons.image)),

                                title: Text(product['name'] ?? ''),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (product['category'] != null) Text('Category: ${product['category']}'),
                                    if (product['description'] != null) Text(product['description']),
                                    Text('Price: ${product['price']} per ${product['unit']}'),
                                    Text('Available: ${product['quantity']} ${product['unit']}'),
                                  ],
                                ),

                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 24),
                  // Sold Products
                  const Text(
                    'Sold Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF5A6B4F)),
                  ),
                  const SizedBox(height: 8),
                  soldProducts.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('No products sold yet.', style: TextStyle(color: Colors.grey)),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: soldProducts.length,
                          itemBuilder: (context, index) {
                            final product = soldProducts[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              color: const Color(0xFFD1E7DD),
                              child: ListTile(
                                leading: (product['image'] != null)
                                    ? Image.asset(product['image'], width: 50, height: 50, fit: BoxFit.cover)
                                    : (product['imageFile'] != null
                                        ? Image.file(product['imageFile'], width: 50, height: 50, fit: BoxFit.cover)
                                        : const Icon(Icons.image)),

                                title: Text(product['name'] ?? ''),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (product['category'] != null) Text('Category: ${product['category']}'),
                                    if (product['description'] != null) Text(product['description']),
                                    Text('Sold for: ${product['price']} per ${product['unit']}'),
                                    Text('Quantity: ${product['quantity']} ${product['unit']}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 24),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesUI() {
    return Container(
      color: const Color(0xFFA8B5A0),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Messages', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade200,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: const Text('Buyer John Doe'),
              subtitle: const Text('Hi, is your maize fresh?'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade200,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: const Text('Buyer Jane Smith'),
              subtitle: const Text('How many kgs do you have left?'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text('No more messages', style: TextStyle(color: Colors.grey[600])),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountUI() {
    final user = (ModalRoute.of(context)?.settings.arguments as Map?)?['user'];
    final firebaseUser = user ?? FirebaseAuth.instance.currentUser;
    final displayName = firebaseUser?.displayName ?? 'Farmer';
    final email = firebaseUser?.email ?? 'No email';

    return Container(
      color: const Color(0xFFA8B5A0),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/images/user_avatar.png'),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(displayName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(email, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ),
          const SizedBox(height: 32),
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: const Icon(Icons.settings, color: Colors.green),
              title: const Text('Settings'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.orange),
              title: const Text('Help & Support'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onNavTap,
      selectedItemColor: const Color(0xFF7A8471),
      unselectedItemColor: const Color(0xFF5A6B4F).withOpacity(0.5),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Current',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }
}
